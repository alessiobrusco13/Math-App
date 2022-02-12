//
//  LinearSystem.swift
//  LinearSystem
//
//  Created by Alessio Garzia Marotta Brusco on 26/08/2021.
//

import Foundation
import SwiftUI

/// A value  type representing a linear system of first or second grade.
struct LinearSystem {

    /// A tuple with equations contained in a linear system.
    var equations: (first: Equation, second: Equation, third: Equation?)

    /// The level of compatibility among the equations contained in the linear system.
    let compatibility: Compatibility

    /// The equation number of the linear system.
    let equationNumber: EquationNumber

    static var example: LinearSystem = {
        let first = Equation(xTerm: 4, yTerm: 6, zTerm: 3, nTerm: 1)
        let second = Equation(xTerm: 5, yTerm: 1, zTerm: 12, nTerm: 43)
        let third = Equation(xTerm: 2, yTerm: 9, zTerm: 7, nTerm: 21)

        let equations = (first, second, third)
        return try! LinearSystem(equations: equations)
    }()

    /// Initializes a `LinearSystem` with the given equations.
    /// This initializer also determines the system's compatibility and its equationNumber.
    /// - Parameter equations: A tuple containing two Equation objects and an Equation? object.
    /// - Throws: A `SystemError` if the *equations* has invalid format.
    ///
    /// The *equations* tuple has to respect the following rules:
    /// * If the *third* parameter is set to `nil`,
    /// also the *z* property for the equations set for the other parameters must be `nil`.
    /// * If the *third* parameter is not set to `nil`,
    /// also the *z* property for the equations set for the other parameters must not be `nil`.
    init(equations: (first: Equation, second: Equation, third: Equation?)) throws {
        // Checks if the equations have the right format
        if equations.third == nil {
            guard equations.first.zTerm == nil,
                  equations.second.zTerm == nil else {
                throw SystemError.badEquations
            }

            self.equations = equations
            self.equationNumber = .two

        } else if let thirdEquation = equations.third {
            guard equations.first.zTerm != nil,
                  equations.second.zTerm != nil,
                  thirdEquation.zTerm != nil else {
                throw SystemError.badEquations
            }

            self.equations = equations
            self.equationNumber = .three
        } else {
            fatalError("Failed to initialize a linear system")
        }

        let firstEquation = equations.first
        let secondEquation = equations.second

        // Checks that there are three equations, and that they're in the correct format.
        if let thirdEquation = equations.third,
           let firstZ = equations.first.zTerm,
           let secondZ = equations.second.zTerm,
           let thirdZ = thirdEquation.zTerm {
            let d: Double = {
                let first = (firstEquation.xTerm * secondEquation.yTerm * thirdZ)
                let second = (firstEquation.yTerm * secondZ * thirdEquation.xTerm)
                let third = (firstZ * secondEquation.xTerm * thirdEquation.xTerm)
                let fourth = (firstZ * secondEquation.xTerm * thirdEquation.xTerm)
                let fifth = (firstEquation.xTerm * secondEquation.xTerm * thirdZ)
                let sixth = (firstEquation.xTerm * secondZ * thirdEquation.xTerm)

                return first + second + third - fourth - fifth - sixth
            }()

            let dX: Double = {
                let first = (firstEquation.nTerm * secondEquation.xTerm * thirdZ)
                let second = (firstEquation.xTerm * secondZ * thirdEquation.nTerm)
                let third = (firstZ * secondEquation.nTerm * thirdEquation.xTerm)
                let fourth = (firstZ * secondEquation.xTerm * thirdEquation.nTerm)
                let fifth = (firstEquation.xTerm * secondEquation.nTerm * thirdZ)
                let sixth = (firstEquation.nTerm * secondZ * thirdEquation.xTerm)

                return first + second + third - fourth - fifth - sixth
            }()

            let dY: Double = {
                let first = (firstEquation.xTerm * secondEquation.nTerm * thirdZ)
                let second = (firstEquation.nTerm * secondZ * thirdEquation.xTerm)
                let third = (firstZ * secondEquation.xTerm * thirdEquation.nTerm)
                let fourth = (firstZ * secondEquation.nTerm * thirdEquation.xTerm)
                let fifth = (firstEquation.nTerm * secondEquation.xTerm * thirdZ)
                let sixth = (firstEquation.xTerm * secondZ * thirdEquation.nTerm)

                return first + second + third - fourth - fifth - sixth
            }()

            let dZ: Double = {
                let first = (firstEquation.xTerm * secondEquation.xTerm * thirdEquation.nTerm)
                let second = (firstEquation.xTerm * secondEquation.nTerm * thirdEquation.xTerm)
                let third = (firstEquation.nTerm * secondEquation.xTerm * thirdEquation.xTerm)
                let fourth = (firstEquation.nTerm * secondEquation.xTerm * thirdEquation.xTerm)
                let fifth = (firstEquation.xTerm * secondEquation.xTerm * thirdEquation.nTerm)
                let sixth = (firstEquation.xTerm * secondEquation.nTerm * thirdEquation.xTerm)

                return first + second + third - fourth - fifth - sixth
            }()

            if d != 0 {
                compatibility = .compatible
            } else if dY == 0 && dX == 0 && dZ == 0 {
                compatibility = .undetermined
            } else {
                compatibility = .incompatible
            }
        } else {
            if (firstEquation.xTerm == 0 && secondEquation.xTerm == 0)
                || (firstEquation.yTerm == 0 && secondEquation.yTerm == 0)
                || (firstEquation.xTerm == 0 && firstEquation.yTerm == 0)
                || (secondEquation.xTerm == 0 && secondEquation.yTerm == 0) {
                compatibility = .notALinearSystem
            } else if ((firstEquation.xTerm / secondEquation.xTerm) != (firstEquation.yTerm / secondEquation.yTerm))
                        || (firstEquation.yTerm == 0
                        || secondEquation.yTerm == 0
                        || firstEquation.xTerm == 0
                        || secondEquation.xTerm == 0) {
                compatibility = .compatible
            } else if (firstEquation.xTerm / secondEquation.xTerm) == (firstEquation.nTerm / secondEquation.nTerm) {
                compatibility = .undetermined
            } else {
                compatibility = .incompatible
            }
        }
    }

    init() {
        let equation = Equation(xTerm: 0, yTerm: 0, zTerm: 0, nTerm: 0)
        let equations = (equation, equation, equation)

        try! self.init(equations: equations) // swiftlint:disable:this force_try
    }

    /// The value type that represents the solution for a linear system.
    struct Solution: Equatable {
        let xTerm: Double
        let yTerm: Double
        let zTerm: Double?

        static func ==(lhs: Solution, rhs: Solution) -> Bool {
            lhs.xTerm.rounded() == rhs.xTerm.rounded()
                && lhs.yTerm.rounded() == rhs.yTerm.rounded()
                && lhs.zTerm?.rounded() == rhs.zTerm?.rounded()
        }

        init(xTerm: Double, yTerm: Double, zTerm: Double? = nil) {
            self.xTerm = xTerm
            self.yTerm = yTerm
            self.zTerm = zTerm
        }
    }

    /// The linear system's number of equations.
    ///
    /// The number of equations are the following:
    /// * *Two*.
    /// * *Three*.
    enum EquationNumber: String, CaseIterable {
        case two = "2"
        case three = "3"

        var name: LocalizedStringKey {
            switch self {
            case .two:
                return "Two Equations"
            case .three:
                return "Three Equations"
            }
        }
    }

    /// The compatibility level among the equations contained in the linear system.
    ///
    /// The possible compatibility leve are the following:
    /// * *Compatible*.
    /// * *Incompatible*.
    /// * *Undetermined*.
    /// * *Not a linear system*.
    enum Compatibility {
        case compatible, incompatible, undetermined, notALinearSystem
    }

    /// The errors that could be thrown while creating a new `LinearSystem`.
    ///
    /// The possible errors are the following:
    /// * *Bad equations*; The equations set during the initialization were not in the requested format.
    enum SystemError: Error {
        case badEquations

        var localizedDescription: String {
            switch self {
            case .badEquations:
                return "The equations set during the initialization were not in the requested format."
            }
        }
    }
}

