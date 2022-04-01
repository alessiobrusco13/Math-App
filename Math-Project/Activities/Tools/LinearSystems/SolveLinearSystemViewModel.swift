//
//  SolveLinearSystemViewModel.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import Foundation

extension SystemSolutionView {
    class ViewModel: ObservableObject {
        let linearSystem: LinearSystem

        var error: LinearSystem.SystemError?
        var solution: LinearSystem.Solution?

        init(linearSystem: LinearSystem) {
            self.linearSystem = linearSystem
        }

        func solve() {
            do {
                solution = try SystemSolver.solution(for: linearSystem, using: .gauss)
            } catch {
                self.error = error as? LinearSystem.SystemError
                print(error.localizedDescription)
            }
        }
    }
}
