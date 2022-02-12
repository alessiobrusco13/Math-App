//
//  CreateSystemEquationView.swift
//  CreateSystemEquationView
//
//  Created by Alessio Garzia Marotta Brusco on 03/09/2021.
//

import SwiftUI

struct CreateSystemEquationView: View {
    var focused: FocusState<LinearSystem.EquationPosition?>.Binding?
    private let position: LinearSystem.EquationPosition?

    let number: LocalizedStringKey?
    @Binding var equation: LinearSystem.Equation

    init(_ number: LinearSystem.EquationPosition, equation: Binding<LinearSystem.Equation>, focused: FocusState<LinearSystem.EquationPosition?>.Binding) {
        self.number = number.rawValue
        self.position = number
        self._equation = Binding(projectedValue: equation)
        self.focused = focused
    }

    init(equation: Binding<LinearSystem.Equation>) {
        self.number = nil
        self.position = nil
        self._equation = equation
        self.focused = nil
    }

    var body: some View {
        if let number = number, let focused = focused, let position = position {
            VStack(alignment: .center) {
                Text(number)
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Spacer()

                VStack(spacing: 64) {
                    SystemEquationView(equation: $equation)
                    EquationTextFields(focused: focused, equation: $equation, position: position)
                        .padding(.horizontal, 64)
                }

                Spacer()
            }
        } else {
            VStack(spacing: 64) {
                SystemEquationView(equation: $equation)
                EquationTextFields(equation: $equation)
                    .padding(.horizontal, 64)
                    .frame(maxWidth: 350)
            }
        }
    }
}

struct CreateSystemEquationView_Previews: PreviewProvider {
    @FocusState static private var focused: LinearSystem.EquationPosition?

    static var previews: some View {
        CreateSystemEquationView(.second, equation: .constant(.example), focused: $focused)
    }
}
