//
//  Equation.swift
//  Equation
//
//  Created by Alessio Garzia Marotta Brusco on 26/08/2021.
//

import Foundation

extension LinearSystem {
    /// A linear equation value type.
    struct Equation: Equatable {
        enum Term: String, Hashable {
            case x = "x"
            case y = "y"
            case z = "z"
            case n = "n"
        }

        var xTerm: Double
        var yTerm: Double
        var zTerm: Double?
        var nTerm: Double

        static let example = Equation(xTerm: 23, yTerm: -3.2, zTerm: 0.3, nTerm: -22)

        /// Creates a new instance of the 'Equation' type.
        init(xTerm: Double, yTerm: Double, zTerm: Double? = nil, nTerm: Double) {
            self.xTerm = xTerm
            self.yTerm = yTerm
            self.zTerm = zTerm
            self.nTerm = nTerm
        }

        init() {
            self.init(xTerm: 1, yTerm: 1, zTerm: 1, nTerm: 1)
        }

        public static func == (lhs: Equation, rhs: Equation) -> Bool {
            return lhs.xTerm == rhs.xTerm
                && lhs.yTerm == rhs.yTerm
                && lhs.zTerm == rhs.zTerm
                && lhs.nTerm == rhs.nTerm
        }

        func formatted() -> String {
            let formattedX = formattedTerm(.x, value: xTerm, plusNeeded: false)
            let formattedY = formattedTerm(.y, value: yTerm)
            let formattedZ = formattedTerm(.z, value: zTerm)
            let formattedN = formattedTerm(.n, value: nTerm)

            return formattedX.sign + formattedX.term + formattedY.sign + formattedY.term + formattedZ.sign + formattedZ.term  + formattedN.sign + formattedN.term + " = 0 "
        }

        private func formattedTerm(
            _ term: Term,
            value: Double?,
            plusNeeded: Bool = true
        ) -> (term: String, sign: String) {
            guard let value = value else {
                return ("", "")
            }

            if value == 0 && term == .n {
                return ("", "")
            }

            var formattedTerm = ""
            var formattedSign = ""

            if abs(value) == 1 {
                formattedTerm = (term == .n) ? " 1 " : term.rawValue
            } else {
                formattedTerm = "\(abs(value).formatted())\((term == .n) ? "" : term.rawValue)"
            }

            if value < 0 {
                formattedSign = " - "
            } else if value > 0 && plusNeeded {
                formattedSign = " + "
            }

            return (formattedTerm, formattedSign)
        }
    }
}
