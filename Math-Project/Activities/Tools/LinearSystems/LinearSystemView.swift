//
//  LinearSystemView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 07/11/2021.
//

import SwiftUI

struct LinearSystemView: View {
    let linearSystem: LinearSystem

    var body: some View {
        HStack {
            Brace()
                .aspectRatio(0.3, contentMode: .fit)
                .frame(maxHeight: 150)

            VStack(alignment: .leading, spacing: 8) {
                SystemEquationView(equation: linearSystem.equations.first)
                SystemEquationView(equation: linearSystem.equations.second)

                if let thirdEquation = linearSystem.equations.third {
                    SystemEquationView(equation: thirdEquation)
                }
            }
            .offset(x: -20)
        }
        .onAppear {
            UIApplication.shared.unfocus()
        }
    }
}

struct LinearSystemView_Previews: PreviewProvider {
    static var previews: some View {
        LinearSystemView(linearSystem: .example)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
