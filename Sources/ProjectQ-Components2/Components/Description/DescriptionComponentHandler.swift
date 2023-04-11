//
//  DescriptionComponentHandler.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 11.04.2023.
//

import Foundation

struct DescriptionComponentHandlerInput: Codable {
    let description: String
}

class DescriptionComponentHandler: DataComponentHanlder {
    init(input: Data) {
        self.input = input
    }
    
    func data() -> String {
        guard let _struct = try? JSONDecoder().decode(DescriptionComponentHandlerInput.self, from: self.input) else {
            return "Error: JSONDecoder could not have parsed input"
        }
        return _struct.description
    }
    
    /* private */ var input: Data
}
