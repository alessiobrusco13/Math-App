//
//  SystemSolutionView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import SwiftUI

struct SystemSolutionView: View {
    @StateObject private var viewModel: ViewModel
    @State private var solutionMethod = SystemSolver.SolutionMethod.gauss

    var body: some View {
        VStack(alignment: .leading) {
            if let solution = viewModel.solution {
                Text("x = \(solution.xTerm, format: .coefficient) ")
                Text("y = \(solution.yTerm, format: .coefficient) ")

                if let zTerm = solution.zTerm {
                    Text("z = \(zTerm, format: .coefficient) ")
                }
            } else {
                Color.red
            }
        }
        .font(.equation)
        .onAppear {
            viewModel.solve()
        }
    }

    init(linearSystem: LinearSystem) {
        let model = ViewModel(linearSystem: linearSystem)
        _viewModel = StateObject(wrappedValue: model)
    }
}

struct SolveLinearSystemView_Previews: PreviewProvider {
    static var previews: some View {
        SystemSolutionView(linearSystem: .example)
    }
}
