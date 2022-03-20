//
//  Term.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import Foundation

struct Term {
    var value: Decimal
    let variable: Variable?

    static let zeroX = Term(0, .x)
    static let zeroSqX = Term(0, .sqX)
    static let zero = Term(0)

    static func x(_ value: Decimal) -> Term {
        Term(value, .x)
    }

    static func sqX(_ value: Decimal) -> Term {
        Term(value, .sqX)
    }

    static func n(_ value: Decimal) -> Term {
        Term(value)
    }

    init(_ value: Decimal, _ variable: Variable? = nil) {
        self.value = value
        self.variable = variable
    }
}
