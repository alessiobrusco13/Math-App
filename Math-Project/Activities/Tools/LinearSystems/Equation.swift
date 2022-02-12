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

        let equalsToZero: Bool

        var xTerm: Double
        var yTerm: Double
        var zTerm: Double?
        var nTerm: Double

        static let example = Equation(xTerm: 23, yTerm: -3.2, zTerm: 0.3, nTerm: -22)

        /// Creates a new instance of the 'Equation' type.
        init(xTerm: Double, yTerm: Double, zTerm: Double? = nil, nTerm: Double, equalsToZero: Bool = true) {
            self.xTerm = xTerm
            self.yTerm = yTerm
            self.zTerm = zTerm
            self.nTerm = nTerm
            self.equalsToZero = equalsToZero
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

        func formatted(_ format: Equation.Term...) -> String {
            var formattedX = ""
            var formattedY = ""
            var formattedZ = ""
            let formattedN = abs(nTerm).formatted()

            var xSign = ""
            var ySign: String? = " + "
            var zSign: String? = " + "
            let nSign = (nTerm < 0) ? " - " : " + "

            if let zTerm = zTerm {
                if zTerm == 1 || zTerm == -1 {
                    formattedZ = "z"
                } else {
                    formattedZ = abs(zTerm).formatted() + "z"
                }

                if zTerm < 0 { zSign = " - " }
            } else {
                zSign = nil
            }

            if xTerm == 1 || xTerm == -1 {
                formattedX = "x"
            } else {
                formattedX = abs(xTerm).formatted() + "x"
            }

            if xTerm < 0 { xSign = " - " }

            if yTerm == 1 || yTerm == -1 {
                formattedY = "y"
            } else {
                formattedY = abs(yTerm).formatted() + "y"
            }

            if yTerm < 0 { ySign = " - " }

            var formatted = ""
            let uniquedFormat = OrderedSet(array: format).array

            for index in uniquedFormat.indices {
                switch uniquedFormat[index] {
                case .x:
                    formatted.append(xSign + formattedX)
                case .y:
                    if let ySign = ySign {
                        formatted.append(ySign + formattedY)
                    }
                case .z:
                    if zTerm != nil {
                        if let zSign = zSign {
                            formatted.append(zSign + formattedZ)
                        }
                    }
                case .n:
                    if equalsToZero {
                        formatted.append(nSign + formattedN + " = 0")
                    } else {
                        formatted.append(formattedN)
                    }
                }
            }

            return formatted
        }
    }
}
