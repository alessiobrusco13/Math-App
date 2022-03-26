//
//  SolveLinearSystemView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import SwiftUI

struct SolveLinearSystemView: View {
    @StateObject private var viewModel: ViewModel
    @State private var solutionMethod = SystemSolver.SolutionMethod.gauss

    var body: some View {
        Text("HELLO WORLD")
    }

    init(linearSystem: LinearSystem) {
        let model = ViewModel(linearSystem: linearSystem)
        _viewModel = StateObject(wrappedValue: model)
    }
}

struct SolveLinearSystemView_Previews: PreviewProvider {
    static var previews: some View {
        SolveLinearSystemView(linearSystem: .example)
    }
}
