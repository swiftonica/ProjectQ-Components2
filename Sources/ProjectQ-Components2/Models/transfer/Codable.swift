//
//  File.swift
//
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation

public struct CodableComponent: Codable {
    public init(pureNumber: Int, handlerInput: Data) {
        self.pureNumber = pureNumber
        self.handlerInput = handlerInput
    }
    
    public let pureNumber: Int
    public let handlerInput: Data
}

public struct CodableTask: Codable {
    public init(name: String, codableComponents: [CodableComponent]) {
        self.name = name
        self.codableComponents = codableComponents
    }
    
    public let name: String
    public let codableComponents: [CodableComponent]
}

public struct CodablePackage: Codable {
    public init(name: String, codableTasks: [CodableTask]) {
        self.name = name
        self.codableTasks = codableTasks
    }
    
    public let name: String
    public let codableTasks: [CodableTask]
}


