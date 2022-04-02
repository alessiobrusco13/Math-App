//
//  SolveSystemButtons.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 26/03/22.
//

import SwiftUI

struct SolveSystemButtons: View {
    @Binding var showingSolution: Bool
    @Binding var showingLinearSystem: Bool

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack {
            if showingSolution {
                BackButton(action: dismiss.callAsFunction)
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
            }

            dismissButton
        }
        .padding(.horizontal)
    }

    var dismissButton: some View {
        Button {
            withAnimation(.card) {
                if !showingSolution {
                    showingSolution = true
                } else {
                    showingLinearSystem = false
                    showingSolution = false
                }
            }
        } label: {
            Text(showingSolution ? "Dismiss" : "Solve")
                .frame(maxWidth: 350)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

struct SolveSystemButton_Previews: PreviewProvider {
    static var previews: some View {
        SolveSystemButtons(showingSolution: .constant(true), showingLinearSystem: .constant(true))
    }
}
