//
//  Filter.swift
//
//  Created by Gabe Kangas on 10/31/18.
//

import Foundation

public struct Filter {
    public let id: String
    public let phrase: String
    public let context: [String]
    public let expires: String?
    public let irreversible: Bool
    public let wholeWord: Bool
}

extension Filter {
    init?(from dictionary: JSONDictionary) {
        guard
            let id = dictionary["id"] as? String,
            let phrase = dictionary["phrase"] as? String,
            let context = dictionary["context"] as? [String],
            let irreversible = dictionary["irreversible"] as? Bool,
            let wholeWord = dictionary["whole_word"] as? Bool

            else {
                return nil
        }
        
        self.id = id
        self.phrase = phrase
        self.context = context
        self.expires = dictionary["expires_at"] as? String
        self.irreversible = irreversible
        self.wholeWord = wholeWord
    }
}

