//
//  File.swift
//
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation

public struct Task {
    public init(name: String, components: [Component]) {
        self.name = name
        self.components = components
    }
    
    public init(codableTask: CodableTask) {
        self.init(name: codableTask.name, components: codableTask.codableComponents.components)
    }
    
    public let name: String
    public let components: [Component]
    
    static let empty = Task(name: "", components: [])
}

public struct Package {
    public init(name: String, tasks: [Task]) {
        self.name = name
        self.tasks = tasks
    }
    
    public init(codablePackage: CodablePackage) {
        self.init(name: codablePackage.name, tasks: codablePackage.codableTasks.tasks)
    }
    
    public let name: String
    public let tasks: [Task]
    
    static let empty = Package(name: "", tasks: [])
}

