import Foundation

public struct Tag {
    /// The hashtag, not including the preceding #.
    public let name: String
    /// The URL of the hashtag.
    public let url: String
    /// The last day used
    public var day: Date?
    /// Number of uses
    public var uses: Int?
    /// Accounts associated with this tag
    public var accounts: [Account]?
}

extension Tag {
    init?(from dictionary: JSONDictionary) {
        guard
            let name = dictionary["name"] as? String,
            let url = dictionary["url"] as? String
            else {
                return nil
        }

        self.name = name
        self.url = url
        
        if let history = dictionary["history"] as? JSONDictionary {
            if let dayString = history["day"] as? String {
                self.day = DateFormatter.mastodonFormatter.date(from: dayString)
            }
            self.uses = history["uses"] as? Int
            if let accountArray = dictionary["accounts"] as? [JSONDictionary] {
                self.accounts = accountArray.compactMap({ return Account(from: $0) })
            }
        }
    }
}
