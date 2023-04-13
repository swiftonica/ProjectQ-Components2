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
    
    var codableTask: CodableTask {
        return CodableTask(task: self)
    }
}

public extension Array where Element == Task {
    var codableTasks: [CodableTask] {
        return self.compactMap {
            return $0.codableTask
        }
    }
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
    
    var codablePackage: CodablePackage {
        return CodablePackage(package: self)
    }
}

public extension Array where Element == Package {
    var codablePackages: [CodablePackage] {
        return self.compactMap {
            return $0.codablePackage
        }
    }
}
