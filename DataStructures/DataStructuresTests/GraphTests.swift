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
        
        let neighborsV = g.neighborsForVertex(v)!
        let neighborsU = g.neighborsForVertex(u)!
        let neighborsW = g.neighborsForVertex(w)!
        
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
}