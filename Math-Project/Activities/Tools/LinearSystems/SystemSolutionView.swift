//
//  SystemSolutionView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import SwiftUI

struct SystemSolutionView: View {
    @Binding var isPresented: Bool
    @Binding var isFlipped: Bool

    @StateObject private var viewModel: ViewModel
    @State private var solutionMethod = SystemSolver.SolutionMethod.gauss
    @State private var showingErrorAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            if let solution = viewModel.solution {
                Text("x = \(solution.xTerm, format: .coefficient) ")
                Text("y = \(solution.yTerm, format: .coefficient) ")

                if let zTerm = solution.zTerm {
                    Text("z = \(zTerm, format: .coefficient) ")
                }
            }
        }
        .font(.equation)
        .onChange(of: isFlipped) { _ in
            if isFlipped && viewModel.error != nil {
                showingErrorAlert = true
            }
        }
        .alert("The Linear System couldn't be sovled.", isPresented: $showingErrorAlert, presenting: viewModel.error) { _ in
            Button("OK") {
                withAnimation {
                    isPresented.toggle()
                    isFlipped = false
                }
            }
        } message: { error in
            Text(error.localizedDescription)
        }
        .onAppear {
            viewModel.solve()
        }
    }

    init(linearSystem: LinearSystem, isPresented: Binding<Bool>, isFlipped: Binding<Bool>) {
        _isPresented = isPresented
        _isFlipped = isFlipped

        let model = ViewModel(linearSystem: linearSystem)
        _viewModel = StateObject(wrappedValue: model)
    }
}

struct SolveLinearSystemView_Previews: PreviewProvider {
    static var previews: some View {
        SystemSolutionView(linearSystem: .example, isPresented: .constant(true), isFlipped: .constant(true))
    }
}
