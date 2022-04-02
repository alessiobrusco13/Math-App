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

        var error: SystemSolver.SolutionError?
        var solution: LinearSystem.Solution?

        init(linearSystem: LinearSystem) {
            self.linearSystem = linearSystem
        }

        func solve() {
            do {
                let solution = try SystemSolver.solution(for: linearSystem, using: .gauss)
                guard solution.xTerm != .nan && solution.yTerm != .nan && (solution.zTerm ?? 0) != .nan else {
                    error = .systemNotCompatible
                    return
                }
            } catch {
                self.error = error as? SystemSolver.SolutionError
                print(error.localizedDescription)
            }
        }
    }
}
