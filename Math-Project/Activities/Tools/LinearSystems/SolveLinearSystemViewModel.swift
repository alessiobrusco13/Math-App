//
//  SolveLinearSystemViewModel.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import Foundation

extension SolveLinearSystemView {
    class ViewModel: ObservableObject {
        let linearSystem: LinearSystem

        @Published var solutionMethod = SystemSolver.SolutionMethod.cramer

        init(linearSystem: LinearSystem) {
            self.linearSystem = linearSystem
        }
    }
}
