//
//  SolveLinearSystemView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import SwiftUI

struct SolveLinearSystemView: View {
    @StateObject private var viewModel: ViewModel

    var body: some View {
        Button("Solve") {
            do {
                let solution = try SystemSolver.solution(for: viewModel.linearSystem, using: .cramer)
                print("\n\n\nX: \(solution.xTerm), Y: \(solution.yTerm), Z: \(solution.zTerm ?? 0)")
            } catch {

            }
        }
    }

    init(linearSystem: LinearSystem) {
        let model = ViewModel(linearSystem: linearSystem)
        _viewModel = StateObject(wrappedValue: model)
    }
}

struct SolveLinearSystemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModalSheetLink(label: "Solve", cornerRadius: 30) {
                SolveLinearSystemView(linearSystem: .example)
            }
            .frame(maxWidth: 350, maxHeight: 44)
            .padding(.horizontal)
        }
    }
}
