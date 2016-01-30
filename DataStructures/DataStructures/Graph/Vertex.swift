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
    var color: VertexColor = .NoColor
    weak var graph: Graph<T>?
    
    init(data: T) {
        self.data = data
    }
    
    var neighbors: [Vertex<T>] {
        if let neighbors = graph?.neighborsForVertex(self) {
            return neighbors
        }
        return [Vertex<T>]()
    }
    
    var inDegree: Int {
        
        guard let hostGraph = self.graph else {
            return 0
        }
        
        return hostGraph.vertices.filter{ (v) -> Bool in
            v.neighbors.contains(self)
        }.count
    }
    
    var outDegree: Int {
       return self.neighbors.count
    }
}