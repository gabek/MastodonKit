import Foundation

public struct Card {
    public let type: String
    /// The url associated with the card.
    public let url: URL
    /// The title of the card.
    public let title: String
    /// The card description.
    public let description: String
    /// The image associated with the card, if any.
    public let image: URL?
    public let authorName: String?
    public let authorUrl: String?
    public let providerName: String?
    public let providerUrl: String?
    public let html: String?
    public let width: Int?
    public let height: Int?
    
}

extension Card {
    init?(from dictionary: JSONDictionary) {
        guard
            let type = dictionary["type"] as? String,
            let urlString = dictionary["url"] as? String,
            let url = URL(string: urlString),
            let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String
            else {
                return nil
        }

        self.type = type
        self.url = url
        self.title = title
        self.description = description
        self.image = dictionary["image"].flatMap(asString).flatMap(URL.init)
        self.authorName = dictionary["author_name"] as? String
        self.authorUrl = dictionary["author_url"] as? String
        self.providerName = dictionary["provider_name"] as? String
        self.providerUrl = dictionary["provider_url"] as? String
        self.html = dictionary["html"] as? String
        self.width = dictionary["width"] as? Int
        self.height = dictionary["height"] as? Int
    }
}
