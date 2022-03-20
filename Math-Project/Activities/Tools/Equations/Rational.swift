//
//  Rational.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import Foundation

struct Rational: ExpressibleByIntegerLiteral {
    var numerator: Int
    var denominator: Int

    var string: String {
        "\(numerator)/\(denominator)"
    }

    static func gcd(_ lhs: Int, _ rhs: Int) -> Int {
        var (lhs, rhs) = (lhs, rhs)
        while rhs != 0 { (lhs, rhs) = (rhs, lhs % rhs) }
        return lhs
    }

    static func lcm(_ lhs: Int, _ rhs: Int) -> Int {
        return lhs * rhs / Rational.gcd(lhs, rhs)
    }

    init(_ numerator: Int, over denominator: Int = 1) {
        self.numerator = numerator
        self.denominator = denominator
    }

    init(integerLiteral value: IntegerLiteralType) {
        numerator = value
        denominator = 1
    }

    mutating func reduce() {
        self = reduced()
    }

    func reduced() -> Rational {
        let divisor = abs(Rational.gcd(numerator, denominator))

        guard divisor != 0 else {
            return Rational(numerator, over: 0)

        }

        return Rational(
            numerator / divisor,
            over: denominator / divisor
        )
    }
}
