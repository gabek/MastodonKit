//
//  AccountMetadataField.swift
//  FlatButton
//
//  Created by Gabe Kangas on 12/25/18.
//

import Foundation

public struct AccountMetadataField {
    public var number: Int
    public var name: String
    public var value: String?
    
    public init(number: Int, name: String, value: String?) {
        self.number = number
        self.name = name
        self.value = value
    }
}
