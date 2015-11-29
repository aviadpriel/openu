//
//  LogicGates.swift
//  CpuSimulation
//
//  Created by Stas Seldin on 29/11/2015.
//  Copyright © 2015 Stas Seldin. All rights reserved.
//

import Foundation
typealias Bit = Int


class LogicGates {
    
    // MARK: AND gate
    class func and(inputs: Bit...) -> (Bit) {
        return and(inputs)
    }
    
    class func and(inputs: [Bit]) -> (Bit) {
        for b in inputs {
            if b == 0 {
                return 0
            }
        }
        return 1
    }
    
    // MARK: OR gate
    class func or(inputs: Bit...) -> (Bit) {
        return or(inputs)
    }
    
    class func or(inputs: [Bit]) -> (Bit) {
        for b in inputs {
            if b == 1 {
                return 1
            }
        }
        return 0
    }
    
    // MARK: NOT gate
    class func not(input: Bit) -> (Bit) {
        return input == 0 ? 1 : 0
    }
    
    // MARK: NOR gate
    class func nor(inputs: Bit...) -> (Bit) {
        return nor(inputs)
    }
    
    class func nor(inputs: [Bit]) -> (Bit) {
        return not(or(inputs))
    }
    
    // MARK: NAND gate
    class func nand(inputs: Bit...) -> (Bit) {
        return nand(inputs)
    }
    
    class func nand(inputs: [Bit]) -> (Bit) {
        return not(and(inputs))
    }
    
    // MARK: XOR gate
    class func xor(inputs: Bit...) -> (Bit) {
        return xor(inputs)
    }
    
    class func xor(inputs: [Bit]) -> (Bit) {
        let count = inputs.filter({$0 == 1}).count
        return count % 2
    }
    
    // MARK: NXOR gate
    class func nxor(inputs: Bit...) -> (Bit) {
        return nxor(inputs)
    }
    
    class func nxor(inputs: [Bit]) -> (Bit) {
        return not(xor(inputs))
    }
    
}