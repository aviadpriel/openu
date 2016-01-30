//
//  Edge.swift
//  DataStructures
//
//  Created by Stas Seldin on 13/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import Foundation

class Edge<T>: NSObject {
    let source: Vertex<T>
    let destination: Vertex<T>
    let weight: Double = 0.0
    
    init(source: Vertex<T>, destination: Vertex<T>) {
        self.source = source
        self.destination = destination
    }
}