//
//  File.swift
//
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation

public protocol ComponentHandler {
    func action()
   
    var input: Data { get }
}
