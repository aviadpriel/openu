//
//  QueueTests.swift
//  DataStructures
//
//  Created by Stas Seldin on 13/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import XCTest
@testable import DataStructures

class QueueTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNewEmptyQueue() {
        let q = Queue<Int>()
        XCTAssertTrue(q.isEmpty())
    }
    
    
    func testIsEmptyAfterAddingItems() {
        let q = Queue<Int>()
        q.enqueue(4)
        XCTAssertFalse(q.isEmpty())
    }
    
    func testIsEmptyAfterRemovingItem() {
        let q = Queue<Int>()
        q.enqueue(5)
        q.denqueue()
        XCTAssertTrue(q.isEmpty())
    }
    
    func testIsEmptyAfterRemovingItems() {
        let q = Queue<Int>()
        q.enqueue(5)
        q.enqueue(2)
        q.enqueue(6)
        q.denqueue()
        q.denqueue()
        q.denqueue()
        XCTAssertTrue(q.isEmpty())
    }
    
    func testPopWithNonEmptyStack() {
        let q = Queue<String>()
        q.enqueue("One")
        q.enqueue("Two")
        q.enqueue("Three")
        
        XCTAssertEqual(q.denqueue(), "One")
        XCTAssertEqual(q.denqueue(), "Two")
        XCTAssertEqual(q.denqueue(), "Three")
    }
    
    func testPopOnEmptyStack() {
        let q = Queue<String>()
        XCTAssertNil(q.denqueue())
    }
    
    func testPeek() {
        let q = Queue<String>()
        q.enqueue("One")
        q.enqueue("two")
        
        XCTAssertEqual(q.peek(), "One")
        XCTAssertEqual(q.peek(), "One")
    }
    
    func testQueuePerformance() {
        
        measureBlock() {
            let q = Queue<Int>()
            for i in 1...50000 {
                q.enqueue(i)
            }
            
            while !q.isEmpty() {
                q.denqueue()
            }
        }
    }
}