//
//  Vertex.swift
//  DataStructures
//
//  Created by Stas Seldin on 13/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import Foundation

class Vertex<T>: NSObject {
    var data: T
    var graph: Graph<T>?
    
    var neighbors: [Vertex<T>] {
        if let neighbors = graph?.neighborsForVertex(self) {
            return neighbors
        }
        return [Vertex<T>]()
    }
    
    init(data: T) {
        self.data = data
    }
}