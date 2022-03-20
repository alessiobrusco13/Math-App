//
//  Variable-Operators.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import Foundation

extension VariableType: Equatable {
    static func == (lhs: VariableType, rhs: VariableType) -> Bool {
        lhs.string == rhs.string
    }
}

extension Variable: Equatable, Comparable {
    static func ==(lhs: Variable, rhs: Variable) -> Bool {
        rhs.type == lhs.type && rhs.exponent == lhs.exponent
    }

    /// Returns a Boolean value indicating whether the two variables are of the same type and the exponent of the first variable is less than the on of the second variable.
    /// - Parameters:
    ///   - lhs: A variable to compare.
    ///   - rhs: Another variable to compare.
    static func <(lhs: Variable, rhs: Variable) -> Bool {
        lhs == rhs && lhs.exponent < rhs.exponent
    }

    /// Returns a Boolean value indicating whether the two variables are of the same type.
    /// - Parameters:
    ///   - lhs: A variable to compare.
    ///   - rhs: Another variable to compare.
    static func ===(lhs: Variable, rhs: Variable) -> Bool {
        lhs.type == rhs.type
    }

    static func *(lhs: Variable, rhs: Variable) -> Variable? {
        guard lhs === rhs else { return nil }
        return Variable(type: lhs.type, exponent: lhs.exponent + rhs.exponent)
    }
}
