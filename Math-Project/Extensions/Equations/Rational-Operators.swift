//
//  Exponent-Operators.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import Foundation

extension Rational: Equatable, Comparable, AdditiveArithmetic {
    static func ==(lhs: Rational, rhs: Rational) -> Bool {
        lhs.numerator == rhs.numerator
        &&
        lhs.denominator == rhs.denominator
    }

    static func <(lhs: Rational, rhs: Rational) -> Bool {
        guard lhs.denominator != 0 && rhs.denominator != 0 else {
            return false
        }

        return lhs.numerator / lhs.denominator < rhs.numerator / rhs.denominator
    }

    static func +(lhs: Rational, rhs: Rational) -> Rational {
        let lcm = Rational.lcm(lhs.denominator, rhs.denominator)
        let a = lcm / lhs.denominator * lhs.numerator
        let b = lcm / rhs.denominator * rhs.numerator

        return Rational(a + b, over: lcm).reduced()
    }

    static func -(lhs: Rational, rhs: Rational) -> Rational {
        let lcm = Rational.lcm(lhs.denominator, rhs.denominator)
        let a = lcm / lhs.denominator * lhs.numerator
        let b = lcm / rhs.denominator * rhs.numerator

        return Rational(a - b, over: lcm).reduced()
    }
}
