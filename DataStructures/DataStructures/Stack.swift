//
//  Stack.swift
//  DataStructures
//
//  Created by Stas Seldin on 09/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import Foundation

public class Stack<T> {
    private var elements: [T]
    
    public init() {
        self.elements = [T]()
    }
    
    func isEmpty() -> (Bool) {
        return self.elements.count == 0;
    }
    
    func push(element: T) {
    }
    
    func pop() -> (T) {
        return elements.first!
    }
    
}