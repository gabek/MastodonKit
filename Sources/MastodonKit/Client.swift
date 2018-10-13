import Foundation

public final class Client: NSObject, URLSessionTaskDelegate, URLSessionDataDelegate {
    let baseURL: String
    public var accessToken: String?
    lazy var session = URLSession.shared
    var streamSession: URLSession?
    public var statusCallback: ((Status?, Error?) -> Void)?
    public var errorCallback: ((Error) -> Void)?
    public var notificationCallback: ((Notification?, Error?) -> Void)?
    public var deleteCallback: ((String) -> Void)?

    public init(baseURL: String, accessToken: String? = nil) {
        self.baseURL = baseURL
        self.accessToken = accessToken
    }

    public func run<Model>(_ request: Request<Model>, completion: @escaping (Model?, Error?) -> Void) {
        guard
            let components = URLComponents(baseURL: baseURL, request: request),
            let requestURL = components.url
            else {
                completion(nil, ClientError.malformedURL)
                return
        }

        let urlRequest = URLRequest(url: requestURL, request: request, accessToken: accessToken)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard
                let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
                else {
                    completion(nil, ClientError.dataError)
                    return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
                else {
                    let mastodonError = MastodonError(json: jsonObject)
                    completion(nil, ClientError.mastodonError(mastodonError.description))
                    return
            }

            completion(request.parse(jsonObject), nil)
        }

        task.resume()
    }
    
    
    /// STREAMING
    private var streamingTask: URLSessionDataTask? = nil
    
    public func stream<Model>(_ request: Request<Model>) {
        guard
            let components = URLComponents(baseURL: baseURL, request: request),
            let requestURL = components.url
            else {
                //completion(nil, ClientError.malformedURL)
                return
        }
        
        let urlRequest = URLRequest(url: requestURL, request: request, accessToken: accessToken)
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        streamSession = URLSession(configuration: config, delegate: self, delegateQueue: .main)
        streamingTask = streamSession?.dataTask(with: urlRequest)
        streamingTask?.resume()
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // TODO: Pull out the "event:" type to determine if it's a update, notification or delete.
        guard let stringData = String(data: data, encoding: .utf8) else { return }
        
        if stringData.first == ":" {
            return
        }
        
        guard let eventTypeSubstring = stringData.split(separator: "\n").first?.split(separator: " ").last else { return }
        let streamEventType = String(eventTypeSubstring)
        
        guard let index = stringData.range(of: "data: ")?.upperBound else { return }
        let payloadString = stringData.substring(from: index)
        
        if streamEventType == "delete" {
            deleteCallback?(payloadString.trimmingCharacters(in: .whitespacesAndNewlines))
            return
        }
        
        guard let updateData = payloadString.data(using: .utf8) else { return }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: updateData, options: []) as? JSONDictionary else { return }
        
        if let modelObject = Status(from: jsonObject!) {
            statusCallback?(modelObject, nil)
        } else if let modelObject = Notification(from: jsonObject!) {
            notificationCallback?(modelObject, nil)
        }
    }
    
    public func stopStream() {
        streamSession?.finishTasksAndInvalidate()
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error as NSError? {
            NSLog("task error: %@ / %d", error.domain, error.code)
            errorCallback?(error)
        } else {
            NSLog("task complete")
        }
    }
    
}
