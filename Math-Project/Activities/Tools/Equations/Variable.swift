//
//  Variable.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import Foundation

struct VariableType {
    let string: String

    static let x = VariableType(string: "x")
    static let y = VariableType(string: "y")
}

struct Variable {
    let type: VariableType
    let exponent: Rational

    static let x = Variable(type: .x, exponent: 1)
    static let y = Variable(type: .y, exponent: 1)

    static let sqX = Variable(type: .x, exponent: 2)
    static let sqY = Variable(type: .y, exponent: 2)

    static let sqRtX = Variable(type: .x, exponent: Rational(1, over: 2))
    static let sqRtY = Variable(type: .y, exponent: Rational(1, over: 2))
}
