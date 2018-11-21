import Foundation

public struct Filters {
    /// Fetches a user's mutes.
    ///
    /// - Parameter range: The bounds used when requesting data from Mastodon.
    /// - Returns: Request for `[Filter]`.
    public static func all(range: RequestRange = .default) -> FiltersRequest {
        let parameters = range.parameters(limit: between(1, and: 80, fallback: 40))
        let method = HTTPMethod.get(Payload.parameters(parameters))
        
        return FiltersRequest(path: "/api/v1/filters", method: method, parse: FiltersRequest.parser)
    }
    
    /// Creates a Filter.
    ///
    /// - Parameter phrase: The phrase to filter.
    /// - Returns: Request for `Filter`.
    public static func create(phrase: String, contexts: [String], irreversible: Bool, wholeWord: Bool) -> FiltersRequest {
        let parameters = [
            Parameter(name: "phrase", value: phrase),
            Parameter(name: "context", value: contexts),
            Parameter(name: "irreversible", value: irreversible),
            Parameter(name: "whole_word", value: wholeWord),
        ]
        
        let method = HTTPMethod.post(Payload.parameters(parameters))
        return FiltersRequest(path: "/api/v1/filters", method: method, parse: FiltersRequest.parser)
    }
    
    /// Creates a Filter.
    ///
    /// - Parameter id: The account id.
    /// - Returns: Request for `Filter`.
    public static func delete(id: String) -> FiltersRequest {
        let method = HTTPMethod.delete(Payload.empty)
        return FiltersRequest(path: "/api/v1/filters/\(id)", method: method, parse: FiltersRequest.parser)
    }
}
