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
    
    func bfs(startVertex: Vertex<T>) -> [[Vertex<T>]] {
        //visited color = black
        startVertex.color = .Black
        
        var layers = [[Vertex<T>]]()
        let firstLayer = [startVertex]
        layers.append(firstLayer)
        var previousLayer = firstLayer
        while !previousLayer.isEmpty  {
            var currentLayer = [Vertex<T>]()
            for v in previousLayer {
                //get all non visited neighbors and mark them as visited
                let nonVisited = v.neighbors.filter({ $0.color != .Black })
                nonVisited.forEach({ $0.color = .Black })
                currentLayer += nonVisited
            }
            layers.append(currentLayer)
            previousLayer = currentLayer
        }
        
        layers.removeLast() //last layer is always empty.
        
        return layers
    }
}