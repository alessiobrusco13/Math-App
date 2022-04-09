//
//  SystemSolver.swift
//  SystemSolver
//
//  Created by Alessio Garzia Marotta Brusco on 26/08/2021.
//

import Foundation
import SwiftUI

enum SystemSolver {
    /// Solves a linear system using the preferred method.
    /// - Parameters:
    ///   - system: The LinearSystem object that will be solved.
    ///   - method: The method that will be used to solve the linear system. The solution won't vary based on the method.
    /// - Throws: A `SolutionError` if the `LinearSystem`'s property *compatibility* isn't equal to `.compatible`.
    /// - Returns: A `LinearSystem.Solution` – the solution for the linear system, if no errors are thrown.
    static func solution(for system: LinearSystem, using method: SolutionMethod) throws -> LinearSystem.Solution {
        // Solves the linear system iff it is compatible
        guard system.compatibility == .compatible else { throw SolutionError.systemNotCompatible }

        switch system.equationNumber {
        case .two:
            return Self.solutionForTwoEquations(system, using: method)
        case .three:
            return try Self.solutionForThreeEquations(system, using: method)
        }
    }

    // MARK: Solve two equation systems
    private static func solutionForTwoEquations(_ system: LinearSystem, using method: SolutionMethod, invertSigns: Bool = true) -> LinearSystem.Solution {
        if system.equations.first.xTerm == 0 {
            return solutionForGenericTwoEquations(system)
        } else {
            switch method {
            case .gauss:
                return Self.solutionUsingGaussForTwoEquations(system, invertSigns: invertSigns)
            case .cramer:
                return Self.solutionUsingCramerForTwoEquations(system, invertSigns: invertSigns)
            }
        }
    }

    private static func solutionUsingGaussForTwoEquations(_ system: LinearSystem, invertSigns: Bool ) -> LinearSystem.Solution {
        let firstEquation = system.equations.first
        let secondEquation = system.equations.second

        let firstSecondX = firstEquation.xTerm / secondEquation.xTerm

//        let newSecondX = firstEquation.xTerm - (secondEquation.xTerm / firstSecondX)
        let newSecondY = firstEquation.yTerm - (secondEquation.yTerm * firstSecondX)
        let newSecondN = firstEquation.nTerm - (secondEquation.nTerm * firstSecondX)

        let solutionY = newSecondN / newSecondY
        let solutionX = (firstEquation.nTerm - firstEquation.yTerm * solutionY) / firstEquation.xTerm

        return LinearSystem.Solution(xTerm: solutionX, yTerm: solutionY, invertSigns: invertSigns)
    }

    private static func solutionUsingCramerForTwoEquations(_ system: LinearSystem, invertSigns: Bool) -> LinearSystem.Solution {
        let firstEquation = system.equations.first
        let secondEquation = system.equations.second

        let d = (firstEquation.xTerm * secondEquation.yTerm) - (secondEquation.xTerm * firstEquation.yTerm)
        let dX = (firstEquation.nTerm * secondEquation.yTerm) - (secondEquation.nTerm * firstEquation.yTerm)
        let dY = (firstEquation.xTerm * secondEquation.nTerm) - (secondEquation.xTerm * firstEquation.nTerm)

        let solutionX = dX / d
        let solutionY = dY / d

        return LinearSystem.Solution(xTerm: solutionX, yTerm: solutionY, invertSigns: invertSigns)

    }

    private static func solutionForGenericTwoEquations(_ system: LinearSystem) -> LinearSystem.Solution {
        let firstEquation = system.equations.first
        let secondEquation = system.equations.second

        let calculation = secondEquation.yTerm * firstEquation.nTerm
        let solutionX = (secondEquation.nTerm - ( calculation / firstEquation.yTerm)) / secondEquation.xTerm
        let solutionY = firstEquation.nTerm / firstEquation.yTerm

        return  LinearSystem.Solution(xTerm: solutionX, yTerm: solutionY, invertSigns: true)
    }

    // MARK: Solve three equation systems
    private static func solutionForThreeEquations(_ system: LinearSystem, using method: SolutionMethod) throws -> LinearSystem.Solution {
        switch method {
        case .gauss:
            return try Self.solutionUsingGaussForThreeEquations(system)
        case .cramer:
            return try Self.solutionUsingCramerForThreeEquations(system)
        }
    }

    private static func solutionUsingGaussForThreeEquations(_ system: LinearSystem) throws -> LinearSystem.Solution {
        let firstEquation = system.equations.first
        let secondEquation = system.equations.second

        // Checks that there are three equations, and that they're in the correct format.
        guard let thirdEquation = system.equations.third,
              let firstZ = firstEquation.zTerm,
              let secondZ = secondEquation.zTerm,
              let thirdZ = thirdEquation.zTerm else {
              throw SolutionError.systemInWrongFormat
        }

        let firstSecondX = firstEquation.xTerm / secondEquation.xTerm
        let firstThirdX = firstEquation.xTerm / thirdEquation.xTerm

        let newSecondY = firstEquation.yTerm - (firstSecondX * secondEquation.yTerm)
        let newSecondZ = firstZ - (firstSecondX * secondZ)
        let newSecondN = firstEquation.nTerm - (firstSecondX * secondEquation.nTerm)

        let newSecondEquation = LinearSystem.Equation(xTerm: newSecondY, yTerm: newSecondZ, nTerm: newSecondN)

        let newThirdY = firstEquation.yTerm - (firstThirdX * thirdEquation.yTerm)
        let newThirdZ = firstZ - (firstThirdX * thirdZ)
        let newThirdN = firstEquation.nTerm - (firstThirdX * thirdEquation.nTerm)

        let newThirdEquation = LinearSystem.Equation(xTerm: newThirdY, yTerm: newThirdZ, nTerm: newThirdN)

        let newSystem = try LinearSystem(equations: (newSecondEquation, newThirdEquation, nil))
        let newSystemSolution = Self.solutionForTwoEquations(newSystem, using: .gauss, invertSigns: false)

        let newSystemSolutionX = newSystemSolution.xTerm
        let newSystemSolutionY = newSystemSolution.yTerm

        // swiftlint:disable:next line_length
        let systemSolutionX = (firstEquation.nTerm - (firstEquation.yTerm * newSystemSolutionX) - (firstZ * newSystemSolutionY)) / firstEquation.xTerm

        return LinearSystem.Solution(xTerm: systemSolutionX, yTerm: newSystemSolutionX, zTerm: newSystemSolutionY, invertSigns: true)
    }

    // swiftlint:disable:next function_body_length
    private static func solutionUsingCramerForThreeEquations(_ system: LinearSystem) throws -> LinearSystem.Solution {
        let firstEquation = system.equations.first
        let secondEquation = system.equations.second

        // Checks that there are three equations, and that they're in the correct format.
        guard let thirdEquation = system.equations.third,
              let firstZ = firstEquation.zTerm,
              let secondZ = secondEquation.zTerm,
              let thirdZ = thirdEquation.zTerm else {
              throw SolutionError.systemInWrongFormat
        }

        let d: Double = {
            let first = (firstEquation.xTerm * secondEquation.yTerm * thirdZ)
            let second = (firstEquation.yTerm * secondZ * thirdEquation.xTerm)
            let third = (firstZ * secondEquation.xTerm * thirdEquation.yTerm)
            let fourth = (firstZ * secondEquation.yTerm * thirdEquation.xTerm)
            let fifth = (firstEquation.yTerm * secondEquation.xTerm * thirdZ)
            let sixth = (firstEquation.xTerm * secondZ * thirdEquation.yTerm)

            return first + second + third - fourth - fifth - sixth
        }()

        let dX: Double = {
            let first = (firstEquation.nTerm * secondEquation.yTerm * thirdZ)
            let second = (firstEquation.yTerm * secondZ * thirdEquation.nTerm)
            let third = (firstZ * secondEquation.nTerm * thirdEquation.yTerm)
            let fourth = (firstZ * secondEquation.yTerm * thirdEquation.nTerm)
            let fifth = (firstEquation.yTerm * secondEquation.nTerm * thirdZ)
            let sixth = (firstEquation.nTerm * secondZ * thirdEquation.yTerm)

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
            let first = (firstEquation.xTerm * secondEquation.yTerm * thirdEquation.nTerm)
            let second = (firstEquation.yTerm * secondEquation.nTerm * thirdEquation.xTerm)
            let third = (firstEquation.nTerm * secondEquation.xTerm * thirdEquation.yTerm)
            let fourth = (firstEquation.nTerm * secondEquation.yTerm * thirdEquation.xTerm)
            let fifth = (firstEquation.yTerm * secondEquation.xTerm * thirdEquation.nTerm)
            let sixth = (firstEquation.xTerm * secondEquation.nTerm * thirdEquation.yTerm)

            return first + second + third - fourth - fifth - sixth
        }()

        let solutionX = dX / d
        let solutionY = dY / d
        let solutionZ = dZ / d

        return LinearSystem.Solution(xTerm: solutionX, yTerm: solutionY, zTerm: solutionZ, invertSigns: true)
    }

    /// The method that is going to be used to solve a linear system.
    ///
    /// The solution won't vary based on the method.
    /// # Possible methods
    /// The supported solution methods are the following:
    /// * *Gauss*.
    /// * *Cramer*.
    enum SolutionMethod: String, CaseIterable {
        case gauss = "Gauss"
        case cramer = "Cramer"
    }

    /// The errors that could be thrown while solving a linear system.
    ///
    /// The possible errors are the following:
    /// * *System not compatible*; will be thrown when the `LinearSystem`'s *compatibility* property is not equal to `.compatible`.
    enum SolutionError: Error {
        case systemNotCompatible, systemInWrongFormat

        var localizedDescription: LocalizedStringKey {
            switch self {
            case .systemNotCompatible:
                return "The linear system couldn't be solved because the equations aren't compatible."
            case .systemInWrongFormat:
                return "The linear system couldn't be solved because it isn't in the correct format."
            }
        }
    }
}
