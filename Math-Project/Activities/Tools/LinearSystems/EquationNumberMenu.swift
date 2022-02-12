//
//  EquationNumberMenu.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 25/09/2021.
//

import SwiftUI

struct EquationNumberMenu: View {
    @Binding var equationNumber: LinearSystem.EquationNumber
    let toggleAction: (LinearSystem.EquationNumber) -> Void

    var body: some View {
        Menu {
            Text("Select the number of equations for your linear system.")
                .layoutPriority(1)

            ForEach(LinearSystem.EquationNumber.allCases, id: \.rawValue) { number in
                Button {
                    toggleAction(number)
                } label: {
                    HStack {
                        Label(
                            number.name,
                            systemImage: equationNumber == number
                            ? "checkmark"
                            : number.rawValue
                        )
                            .symbolVariant(
                                equationNumber == number
                                ? .fill
                                : .circle
                            )
                    }
                }
            }
        } label: {
            Image(systemName: equationNumber.rawValue)
                .symbolVariant(.circle)
                .font(.headline)
        }
    }
}
