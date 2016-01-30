//
//  Graph.swift
//  DataStructures
//
//  Created by Stas Seldin on 13/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import Foundation

class Graph<T> {
    private var relations = Dictionary<Vertex<T>, Array<Vertex<T>>>()
    var directed = false
    var edges = [Edge<T>]()
    
    var vertices: [Vertex<T>] {
        return Array(relations.keys)
    }
    
    func addVertex(newVertex: Vertex<T>) {
        if !self.vertices.contains(newVertex) {
            relations[newVertex] = [Vertex<T>]()
        }
        newVertex.graph = self
    }
    
    func addEdge(newEdge: Edge<T>) {
        addVertex(newEdge.source)
        addVertex(newEdge.destination)
        
        relations[newEdge.source]?.append(newEdge.destination)
        
        if !directed {
            relations[newEdge.destination]?.append(newEdge.source)
        }
        
        edges.append(newEdge)
    }
    
    func neighborsForVertex(v: Vertex<T>) -> [Vertex<T>] {
        if let neighbors = self.relations[v] {
            return neighbors
        }
        return [Vertex<T>]()
    }
}