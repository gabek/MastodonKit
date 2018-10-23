import Foundation

public struct Status {
    /// The ID of the status.
    public let id: String
    /// A Fediverse-unique resource ID.
    public let uri: String
    /// URL to the status page (can be remote).
    public var url: URL? = nil
    /// The Account which posted the status.
    public let account: Account
    /// null or the ID of the status it replies to.
    public let inReplyToID: String?
    /// null or the ID of the account it replies to.
    public let inReplyToAccountID: String?
    /// Body of the status; this will contain HTML (remote HTML already sanitized).
    public let content: String
    /// The time the status was created.
    public let createdAt: Date
    /// The number of reblogs for the status.
    public let reblogsCount: Int
    /// The number of favourites for the status.
    public let favouritesCount: Int
    /// The number of replies for the setatus.
    public let repliesCount: Int
    /// Whether the authenticated user has reblogged the status.
    public let reblogged: Bool?
    /// Whether the authenticated user has favourited the status.
    public let favourited: Bool?
    /// Whether media attachments should be hidden by default.
    public let sensitive: Bool?
    /// Whether the authenticated user has muted the conversation this status from
    public let muted: Bool?
    /// If not empty, warning text that should be displayed before the actual content.
    public let spoilerText: String
    /// The visibility of the status.
    public let visibility: Visibility
    /// An array of attachments.
    public let mediaAttachments: [Attachment]
    /// An array of mentions.
    public let mentions: [Mention]
    /// An array of tags.
    public let tags: [Tag]
    /// Application from which the status was posted.
    public let application: Application?
    /// An array of emoji.
    public let emoji: [Emoji]
    public let language: String?
    public let pinned: Bool?
    
    /// The reblogged Status
    public var reblog: Status? {
        return reblogWrapper.first?.flatMap { $0 }
    }

    public var reblogWrapper: [Status?]
}

extension Status {
    init?(from dictionary: JSONDictionary) {
        guard
            let id = dictionary["id"] as? String,
            let uri = dictionary["uri"] as? String,
            let accountDictionary = dictionary["account"] as? JSONDictionary,
            let account = Account(from: accountDictionary),
            let content = dictionary["content"] as? String,
            let createdAtString = dictionary["created_at"] as? String,
            let createdAt = DateFormatter.mastodonFormatter.date(from: createdAtString),
            let reblogsCount = dictionary["reblogs_count"] as? Int,
            let favouritesCount = dictionary["favourites_count"] as? Int,
            let repliesCount = dictionary["replies_count"] as? Int,
            let spoilerText = dictionary["spoiler_text"] as? String,
            let visibilityString = dictionary["visibility"] as? String,
            let attachmentsArray = dictionary["media_attachments"] as? [JSONDictionary],
            let mentionsArray = dictionary["mentions"] as? [JSONDictionary],
            let tagsArray = dictionary["tags"] as? [JSONDictionary],
            let emojiArray = dictionary["emojis"] as? [JSONDictionary]
            else {
                return nil
        }

        if let urlString = dictionary["url"] as? String, let url = URL(string: urlString) {
            self.url = url
        }

        self.id = id
        self.uri = uri
        self.account = account
        self.inReplyToID = dictionary["in_reply_to_id"] as? String
        self.inReplyToAccountID = dictionary["in_reply_to_account_id"] as? String
        self.content = content
        self.createdAt = createdAt
        self.reblogsCount = reblogsCount
        self.favouritesCount = favouritesCount
        self.repliesCount = repliesCount
        self.reblogged = dictionary["reblogged"] as? Bool
        self.favourited = dictionary["favourited"] as? Bool
        self.sensitive = dictionary["sensitive"] as? Bool
        self.spoilerText = spoilerText
        self.visibility = Visibility(string: visibilityString)
        self.reblogWrapper = [dictionary["reblog"].flatMap(asJSONDictionary).flatMap(Status.init)]
        self.application = dictionary["application"].flatMap(asJSONDictionary).flatMap(Application.init)
        self.mediaAttachments = attachmentsArray.compactMap(Attachment.init)
        self.mentions = mentionsArray.compactMap(Mention.init)
        self.tags = tagsArray.compactMap(Tag.init)
        self.emoji = emojiArray.compactMap(Emoji.init)
        self.language = dictionary["language"] as? String
        self.muted = dictionary["muted"] as? Bool ?? false
        self.pinned = dictionary["pinned"] as? Bool ?? false
    }
}
