//
//  Monomial.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import Foundation

struct Monomial: ExpressibleByFloatLiteral {
    var coefficient: Double
    let variables: [Variable]

    static let zero = Monomial(0)

    static func x(_ coefficient: Double) -> Monomial {
        Monomial(coefficient, .x)
    }

    static func sqX(_ coefficient: Double) -> Monomial {
        Monomial(coefficient, .sqX)
    }

    static func n(_ coefficient: Double) -> Monomial {
        Monomial(coefficient)
    }

    init(_ coefficient: Double, _ variable: Variable) {
        self.coefficient = coefficient
        self.variables = [variable]
    }

    init(_ coefficient: Double, _ variables: [Variable] = []) {
        self.coefficient = coefficient
        self.variables = variables
    }

    init(floatLiteral value: FloatLiteralType) {
        self.coefficient = value
        variables = []
    }
}
