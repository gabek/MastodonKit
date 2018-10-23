//
//  Block.swift
//  MastodonKit
//
//  Created by Gabe Kangas on 10/20/18.
//

import Foundation

public struct Block {
    public let name: String
}

extension Block {
    init?(from name: String) {
        self.name = name
    }
}
