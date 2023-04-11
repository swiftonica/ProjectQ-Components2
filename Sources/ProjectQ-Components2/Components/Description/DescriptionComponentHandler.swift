//
//  DescriptionComponentHandler.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 11.04.2023.
//

import Foundation

struct DescriptionComponentHandlerInput: Codable {
    public init(description: String) {
        self.description = description
    }
    
    public let description: String
}

class DescriptionComponentHandler: DataComponentHanlder {
    public init(input: Data) {
        self.input = input
    }
    
    public func data() -> String {
        guard let _struct = try? JSONDecoder().decode(DescriptionComponentHandlerInput.self, from: self.input) else {
            return "Error: JSONDecoder could not have parsed input"
        }
        return _struct.description
    }
    
    /* private */ public var input: Data
}
