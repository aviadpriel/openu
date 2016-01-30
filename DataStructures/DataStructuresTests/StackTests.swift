//
//  DataStructuresTests.swift
//  DataStructuresTests
//
//  Created by Stas Seldin on 09/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import XCTest
@testable import DataStructures

class StackTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNewEmptyStack() {
        let s = Stack<Int>()
        XCTAssertTrue(s.isEmpty())
    }
    
    
    func testIsEmptyAfterAddingItems() {
        let s = Stack<Int>()
        s.push(4)
        XCTAssertFalse(s.isEmpty())
    }
    
    func testIsEmptyAfterRemovingItem() {
        let s = Stack<Int>()
        s.push(5)
        s.pop()
        XCTAssertTrue(s.isEmpty())
    }
    
    func testIsEmptyAfterRemovingItems() {
        let s = Stack<Int>()
        s.push(5)
        s.push(2)
        s.push(6)
        s.pop()
        s.pop()
        s.pop()
        XCTAssertTrue(s.isEmpty())
    }
    
    func testPopWithNonEmptyStack() {
        let s = Stack<String>()
        s.push("One")
        s.push("Two")
        s.push("Three")
        
        XCTAssertEqual(s.pop(), "Three")
        XCTAssertEqual(s.pop(), "Two")
        XCTAssertEqual(s.pop(), "One")
    }
    
    func testPopOnEmptyStack() {
        let s = Stack<String>()
        XCTAssertNil(s.pop())
    }
    
    func testPeek() {
        let s = Stack<String>()
        s.push("One")
        s.push("two")
        
        XCTAssertEqual(s.peek(), "two")
        XCTAssertEqual(s.peek(), "two")
    }
    
}
