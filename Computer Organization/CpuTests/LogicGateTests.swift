//
//  LogicGateTests.swift
//  CpuSimulation
//
//  Created by Stas Seldin on 29/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import Foundation
import XCTest

struct TruthTableRow {
    let input: [Bit]
    let output: Bit
}

class LogicGateTests: XCTestCase {

    
    func testAndGate() {
        let truthTable = [
            TruthTableRow(input: [0], output: 0),
            TruthTableRow(input: [1], output: 1),
            TruthTableRow(input: [0,0], output: 0),
            TruthTableRow(input: [1,0], output: 0),
            TruthTableRow(input: [0,1], output: 0),
            TruthTableRow(input: [1,1], output: 1),
            TruthTableRow(input: [0,0,0], output: 0),
            TruthTableRow(input: [0,0,1], output: 0),
            TruthTableRow(input: [0,1,0], output: 0),
            TruthTableRow(input: [0,1,1], output: 0),
            TruthTableRow(input: [1,0,0], output: 0),
            TruthTableRow(input: [1,0,1], output: 0),
            TruthTableRow(input: [1,1,0], output: 0),
            TruthTableRow(input: [1,1,1], output: 1),
        ]
        
        truthTable.forEach { (model) -> () in
            let result = LogicGates.and(model.input)
            let expectedResult = model.output
            let message = "and input: \(model.input) should be \(model.output). Actual: \(result)"
            XCTAssertEqual(result, expectedResult, message)
        }
    }
    
    func testOrGate() {
        let truthTable = [
            TruthTableRow(input: [0], output: 0),
            TruthTableRow(input: [1], output: 1),
            TruthTableRow(input: [0,0], output: 0),
            TruthTableRow(input: [1,0], output: 1),
            TruthTableRow(input: [0,1], output: 1),
            TruthTableRow(input: [1,1], output: 1),
            TruthTableRow(input: [0,0,0], output: 0),
            TruthTableRow(input: [0,0,1], output: 1),
            TruthTableRow(input: [0,1,0], output: 1),
            TruthTableRow(input: [0,1,1], output: 1),
            TruthTableRow(input: [1,0,0], output: 1),
            TruthTableRow(input: [1,0,1], output: 1),
            TruthTableRow(input: [1,1,0], output: 1),
            TruthTableRow(input: [1,1,1], output: 1),
        ]
        
        truthTable.forEach { (model) -> () in
            let result = LogicGates.or(model.input)
            let expectedResult = model.output
            let message = "or input: \(model.input) should be \(model.output). Actual: \(result)"
            XCTAssertEqual(result, expectedResult, message)
        }
    }
    
    func testNotGate() {
        let notOne = LogicGates.not(1)
        let notZero = LogicGates.not(0)
        
        XCTAssertEqual(notOne, 0, "not(1): expected: 0. Actual: \(notOne) ")
        XCTAssertEqual(notZero, 1, "not(0): expected: 1. Actual: \(notZero) ")
    }
    
    func testNorGate() {
        let truthTable = [
            TruthTableRow(input: [0], output: 1),
            TruthTableRow(input: [1], output: 0),
            TruthTableRow(input: [0,0], output: 1),
            TruthTableRow(input: [1,0], output: 0),
            TruthTableRow(input: [0,1], output: 0),
            TruthTableRow(input: [1,1], output: 0),
            TruthTableRow(input: [0,0,0], output: 1),
            TruthTableRow(input: [0,0,1], output: 0),
            TruthTableRow(input: [0,1,0], output: 0),
            TruthTableRow(input: [0,1,1], output: 0),
            TruthTableRow(input: [1,0,0], output: 0),
            TruthTableRow(input: [1,0,1], output: 0),
            TruthTableRow(input: [1,1,0], output: 0),
            TruthTableRow(input: [1,1,1], output: 0),
        ]
        
        truthTable.forEach { (model) -> () in
            let result = LogicGates.nor(model.input)
            let expectedResult = model.output
            let message = "nor input: \(model.input) should be \(model.output). Actual: \(result)"
            XCTAssertEqual(result, expectedResult, message)
        }
    }
    
    func testNandGate() {
        let truthTable = [
            TruthTableRow(input: [0], output: 1),
            TruthTableRow(input: [1], output: 0),
            TruthTableRow(input: [0,0], output: 1),
            TruthTableRow(input: [1,0], output: 1),
            TruthTableRow(input: [0,1], output: 1),
            TruthTableRow(input: [1,1], output: 0),
            TruthTableRow(input: [0,0,0], output: 1),
            TruthTableRow(input: [0,0,1], output: 1),
            TruthTableRow(input: [0,1,0], output: 1),
            TruthTableRow(input: [0,1,1], output: 1),
            TruthTableRow(input: [1,0,0], output: 1),
            TruthTableRow(input: [1,0,1], output: 1),
            TruthTableRow(input: [1,1,0], output: 1),
            TruthTableRow(input: [1,1,1], output: 0),
        ]
        
        truthTable.forEach { (model) -> () in
            let result = LogicGates.nand(model.input)
            let expectedResult = model.output
            let message = "nand input: \(model.input) should be \(model.output). Actual: \(result)"
            XCTAssertEqual(result, expectedResult, message)
        }
    }
    
    func testXorGate() {
        let truthTable = [
            TruthTableRow(input: [0], output: 0),
            TruthTableRow(input: [1], output: 1),
            TruthTableRow(input: [0,0], output: 0),
            TruthTableRow(input: [1,0], output: 1),
            TruthTableRow(input: [0,1], output: 1),
            TruthTableRow(input: [1,1], output: 0),
            TruthTableRow(input: [0,0,0], output: 0),
            TruthTableRow(input: [0,0,1], output: 1),
            TruthTableRow(input: [0,1,0], output: 1),
            TruthTableRow(input: [0,1,1], output: 0),
            TruthTableRow(input: [1,0,0], output: 1),
            TruthTableRow(input: [1,0,1], output: 0),
            TruthTableRow(input: [1,1,0], output: 0),
            TruthTableRow(input: [1,1,1], output: 1),
        ]
        
        truthTable.forEach { (model) -> () in
            let result = LogicGates.xor(model.input)
            let expectedResult = model.output
            let message = "xor input: \(model.input) should be \(model.output). Actual: \(result)"
            XCTAssertEqual(result, expectedResult, message)
        }
    }
    
    func testNxorGate() {
        let truthTable = [
            TruthTableRow(input: [0], output: 1),
            TruthTableRow(input: [1], output: 0),
            TruthTableRow(input: [0,0], output: 1),
            TruthTableRow(input: [1,0], output: 0),
            TruthTableRow(input: [0,1], output: 0),
            TruthTableRow(input: [1,1], output: 1),
            TruthTableRow(input: [0,0,0], output: 1),
            TruthTableRow(input: [0,0,1], output: 0),
            TruthTableRow(input: [0,1,0], output: 0),
            TruthTableRow(input: [0,1,1], output: 1),
            TruthTableRow(input: [1,0,0], output: 0),
            TruthTableRow(input: [1,0,1], output: 1),
            TruthTableRow(input: [1,1,0], output: 1),
            TruthTableRow(input: [1,1,1], output: 0),
        ]
        
        truthTable.forEach { (model) -> () in
            let result = LogicGates.nxor(model.input)
            let expectedResult = model.output
            let message = "nxor input: \(model.input) should be \(model.output). Actual: \(result)"
            XCTAssertEqual(result, expectedResult, message)
        }
    }
    
    
}
