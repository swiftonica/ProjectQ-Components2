//
//  File.swift
//
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation

public protocol ComponentHandler {
    var input: Data { get }
}

public protocol AppearComponentHandler: ComponentHandler {
    func shouldAppear() -> Bool
}

public protocol DataComponentHandler: ComponentHandler {
    func data() -> String
}

public protocol InteractiveComponentHandler: DataComponentHandler {
    func isDataCorrect(data: Data) -> Bool
    func clear()
}
