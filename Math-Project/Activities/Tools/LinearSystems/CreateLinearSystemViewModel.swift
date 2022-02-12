//
//  CreateLinearSystemViewModel.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 21/09/2021.
//

import Foundation

extension CreateLinearSystemView {
    @MainActor class ViewModel: ObservableObject {
        @Published var firstEquation = LinearSystem.Equation()
        @Published var secondEquation = LinearSystem.Equation()
        @Published var thirdEquation = LinearSystem.Equation()

        @Published var currentEquationNumber = LinearSystem.EquationNumber.three
        @Published var selectedEquation = LinearSystem.EquationPosition.first

        @Published var linearSystem: LinearSystem!

        var shouldCreateLinearSystem: Bool {
            if currentEquationNumber == .two && selectedEquation == .second {
                return true
            }

            if currentEquationNumber == .three && selectedEquation == .third {
                return true
            }

            return false
        }

        func switchEquation() {
            switch selectedEquation {
            case .first:
                selectedEquation = .second

            case .second:
                if currentEquationNumber == .three {
                    selectedEquation = .third
                }

            case .third:
                return
            }
        }

        func goBack() {
            switch selectedEquation {
            case .first:
                return
            case .second:
                selectedEquation = .first
            case .third:
                selectedEquation = .second
            }
        }

        func changeNumber(to number: LinearSystem.EquationNumber) {
            switch number {
            case .two:
                currentEquationNumber = .two

                firstEquation.zTerm = nil
                secondEquation.zTerm = nil

                if selectedEquation == .third {
                    selectedEquation = .second
                }

            case .three:
                currentEquationNumber = .three

                firstEquation.zTerm = 1
                secondEquation.zTerm = 1
            }
        }

        func createLinearSystem() throws {
            let equations: (LinearSystem.Equation, LinearSystem.Equation, LinearSystem.Equation?)

            if currentEquationNumber == .two {
                equations = (firstEquation, secondEquation, nil)
            } else {
                equations = (firstEquation, secondEquation, thirdEquation)
            }

            linearSystem = try LinearSystem(equations: equations)
        }
    }
}
