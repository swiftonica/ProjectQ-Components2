//
//  EmptyHandler.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation
import ProjectQ_Models

public class EmptyHandler: ComponentHandler {
    public func action() {}
    
    public var input: Data
    public var cache: Data?
    
    public init(input: Data = Data(), cache: Data? = nil) {
        self.input = input
        self.cache = cache
    }
}
