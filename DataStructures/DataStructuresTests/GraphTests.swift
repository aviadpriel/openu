//
//  GraphTests.swift
//  DataStructures
//
//  Created by Stas Seldin on 13/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import XCTest
@testable import DataStructures

class GraphTesbts: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyGraph() {
        let g = Graph<Int>()
        XCTAssertTrue(g.vertices.isEmpty)
    }
    
    func testSingleVertexGraph() {
        let g = Graph<Int>()
        let v = Vertex(data: 5)
        g.addVertex(v)
        
        XCTAssertEqual(g.vertices.count, 1)
        XCTAssertEqual(g.vertices.first, v)
    }
    
    func testDuplicateVertex() {
        let g = Graph<Int>()
        let v = Vertex(data: 5)
        g.addVertex(v)
        g.addVertex(v)
        g.addVertex(v)
        
        XCTAssertEqual(g.vertices.count, 1)
        XCTAssertEqual(g.vertices.first, v)
    }
    
    func testTwoVertices() {
        let g = Graph<Int>()
        let v = Vertex(data: 5)
        let u = Vertex(data: 6)
        
        g.addVertex(v)
        g.addVertex(u)
        
        XCTAssertEqual(g.vertices.count, 2)
        XCTAssertTrue(g.vertices.contains(v))
        XCTAssertTrue(g.vertices.contains(u))
    }
    
    func testSingleEdge() {
        let g = Graph<Int>()
        let v = Vertex(data: 5)
        let u = Vertex(data: 6)
        let e = Edge(source: v, destination: u)
        
        g.addVertex(v)
        g.addVertex(u)
        g.addEdge(e)
        
        XCTAssertEqual(g.vertices.count, 2)
        XCTAssertEqual(g.edges.count, 1)
        XCTAssertEqual(g.edges.first!, e)
    }
    
    func testNeighbors() {
        let g = Graph<Int>()
        let v = Vertex(data: 5)
        let u = Vertex(data: 6)
        let w = Vertex(data: 7)
        
        let e1 = Edge(source: v, destination: u)
        let e2 = Edge(source: v, destination: w)
        
        g.addEdge(e1)
        g.addEdge(e2)
        
        let neighborsV = g.neighborsForVertex(v)
        let neighborsU = g.neighborsForVertex(u)
        let neighborsW = g.neighborsForVertex(w)
        
        XCTAssertEqual(neighborsV.count,2)
        XCTAssertTrue(neighborsV.contains(u))
        XCTAssertTrue(neighborsV.contains(w))
        XCTAssertFalse(neighborsV.contains(v))
        
        XCTAssertEqual(neighborsU.count,1)
        XCTAssertTrue(neighborsU.contains(v))
        XCTAssertFalse(neighborsU.contains(w))
        XCTAssertFalse(neighborsU.contains(u))
        
        XCTAssertEqual(neighborsW.count,1)
        XCTAssertTrue(neighborsW.contains(v))
        XCTAssertFalse(neighborsW.contains(w))
        XCTAssertFalse(neighborsW.contains(u))
    }
    
    func testNeighbors_directedGraph() {
        let g = Graph<Int>()
        g.directed = true
        let v = Vertex(data: 5)
        let u = Vertex(data: 6)
        let w = Vertex(data: 7)
        
        let e1 = Edge(source: v, destination: u)
        let e2 = Edge(source: v, destination: w)
        
        g.addEdge(e1)
        g.addEdge(e2)
        
        let neighborsV = g.neighborsForVertex(v)
        let neighborsU = g.neighborsForVertex(u)
        let neighborsW = g.neighborsForVertex(w)
        
        XCTAssertEqual(neighborsV.count,2)
        XCTAssertTrue(neighborsV.contains(u))
        XCTAssertTrue(neighborsV.contains(w))
        XCTAssertFalse(neighborsV.contains(v))
        
        XCTAssertEqual(neighborsU.count,0)
        XCTAssertFalse(neighborsU.contains(v))
        XCTAssertFalse(neighborsU.contains(w))
        XCTAssertFalse(neighborsU.contains(u))
        
        XCTAssertEqual(neighborsW.count,0)
        XCTAssertFalse(neighborsW.contains(v))
        XCTAssertFalse(neighborsW.contains(w))
        XCTAssertFalse(neighborsW.contains(u))
    }
    
    func testInDegree() {
        let g = Graph<Int>()
        g.directed = true
        let v = Vertex(data: 5)
        let u = Vertex(data: 6)
        let w = Vertex(data: 7)
        
        let e1 = Edge(source: v, destination: u)
        let e2 = Edge(source: v, destination: w)
        let e3 = Edge(source: w, destination: u)
        
        g.addEdge(e1)
        g.addEdge(e2)
        g.addEdge(e3)
        
        XCTAssertEqual(v.inDegree, 0)
        XCTAssertEqual(w.inDegree, 1)
        XCTAssertEqual(u.inDegree, 2)
    }
    
    func testOutDegree() {
        let g = Graph<Int>()
        g.directed = true
        let v = Vertex(data: 5)
        let u = Vertex(data: 6)
        let w = Vertex(data: 7)
        
        let e1 = Edge(source: v, destination: u)
        let e2 = Edge(source: v, destination: w)
        let e3 = Edge(source: w, destination: u)
        
        g.addEdge(e1)
        g.addEdge(e2)
        g.addEdge(e3)
        
        XCTAssertEqual(v.outDegree, 2)
        XCTAssertEqual(w.outDegree, 1)
        XCTAssertEqual(u.outDegree, 0)
    }
    
    func testBFS() {
        let g = Graph<Int>()
        let v0 = Vertex(data: 0)
        let v1 = Vertex(data: 1)
        let v2 = Vertex(data: 2)
        let v3 = Vertex(data: 3)
        let v4 = Vertex(data: 4)
        let v5 = Vertex(data: 5)
        let v6 = Vertex(data: 6)
        let v7 = Vertex(data: 7)
        
        let edges = [
            Edge(source: v0, destination: v1),
            Edge(source: v0, destination: v2),
            Edge(source: v1, destination: v3),
            Edge(source: v2, destination: v3),
            Edge(source: v2, destination: v6),
            Edge(source: v1, destination: v2),
            Edge(source: v6, destination: v5),
            Edge(source: v5, destination: v4),
            Edge(source: v3, destination: v4),
            Edge(source: v4, destination: v7)
        ]
        
        edges.forEach({ g.addEdge($0)})
        
        let bfs = g.bfs(v0)
        
        
        
    }
}