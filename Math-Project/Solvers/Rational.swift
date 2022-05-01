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

    init(approximating x0: Double, withPrecision eps: Double = 1.0E-6) {
          var x = x0
          var a = x.rounded(.down)
          var (h1, k1, h, k) = (1, 0, Int(a), 1)

          while x - a > eps * Double(k) * Double(k) {
              x = 1.0/(x - a)
              a = x.rounded(.down)
              (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
          }

        self.init(h, over: k)
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
