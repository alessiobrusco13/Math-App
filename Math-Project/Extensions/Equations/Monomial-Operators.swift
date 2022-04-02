//
//  Monomial-Operators.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 02/04/22.
//

import Foundation

extension Monomial {
    static func -(lhs: Monomial, rhs: Monomial) -> Monomial? {
        guard lhs === rhs else { return nil }
        return Monomial(lhs.coefficient - rhs.coefficient, lhs.variables)
    }

    static prefix func -(lhs: Monomial) -> Monomial {
        Monomial(-lhs.coefficient, lhs.variables)
    }

    static func +(lhs: Monomial, rhs: Monomial) -> Monomial? {
        guard lhs === rhs else { return nil }
        return Monomial(lhs.coefficient + rhs.coefficient, lhs.variables)
    }

    static func *(lhs: Monomial, rhs: Monomial) -> Monomial {
        Monomial(lhs.coefficient * rhs.coefficient, lhs.variables * rhs.variables)
    }


    static func ==(lhs: Monomial, rhs: Monomial) -> Bool {
        lhs.coefficient == rhs.coefficient && lhs.variables == rhs.variables
    }

    static func ===(lhs: Monomial, rhs: Monomial) -> Bool {
        lhs.variables == rhs.variables
    }
}
