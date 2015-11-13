//
//  Queue.swift
//  DataStructures
//
//  Created by Stas Seldin on 13/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import Foundation

public class Queue<T> {
    private var elements: [T]
    
    public init() {
        self.elements = [T]()
    }
    
    func isEmpty() -> (Bool) {
        return self.elements.isEmpty
    }
    
    func enqueue(element: T) {
        elements.append(element)
    }
    
    func denqueue() -> (T?) {
        if isEmpty() {
            return nil
        }
        return elements.removeFirst()
    }
    
    func peek() -> (T?) {
        return elements.first
    }
    
}