//
//  Emoji.swift
//
//  Created by Gabe Kangas on 9/25/18.
//

import Foundation

public struct Emoji {
    public let shortcode: String
    public let url: String
    public let staticUrl: String
    public let visibleInPicker: Bool
}

extension Emoji {
    init?(from dictionary: JSONDictionary) {
        guard
            let shortcode = dictionary["shortcode"] as? String,
            let url = dictionary["url"] as? String,
            let staticUrl = dictionary["static_url"] as? String,
            let visibleInPicker = dictionary["visible_in_picker"] as? Bool
            else {
                return nil
        }
        
        self.shortcode = shortcode
        self.url = url
        self.staticUrl = staticUrl
        self.visibleInPicker = visibleInPicker
    }
}
