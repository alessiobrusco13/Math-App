//
//  SolveSystemButton.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 26/03/22.
//

import SwiftUI

struct SolveSystemButton: View {
    @Binding var showingSolution: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            withAnimation(.card) {
                if !showingSolution {
                    showingSolution.toggle()
                } else {
                    dismiss()
                }
            }
        } label: {
            Text(showingSolution ? "Dismiss" : "Solve")
                .frame(maxWidth: 350)
        }
        .buttonStyle(.borderedProminent)
        .tint(showingSolution ? .red : .accentColor)
        .controlSize(.large)
    }
}

struct SolveSystemButton_Previews: PreviewProvider {
    static var previews: some View {
        SolveSystemButton(showingSolution: .constant(false))
    }
}
