//
//  EquationTermTextFieldStyle.swift
//  EquationTermTextFieldStyle
//
//  Created by Alessio Garzia Marotta Brusco on 17/08/2021.
//

import SwiftUI

struct EquationTermTextField: View {
    @ScaledMetric(relativeTo: .title2) var size = 22

    let term: LinearSystem.Equation.Term
    @Binding var value: Double

    @FocusState private var focused: Bool

    var body: some View {
        HStack {
            Text(term.rawValue + " ")
                .font(.system(size: size, weight: .semibold, design: .serif).italic())

            TextField(term.rawValue + String(localized: "Term"), value: $value, format: .number)
                .focused($focused)
                .textFieldStyle(.plain)
                .keyboardType(.decimalPad)

            Button(action: unfocus) {
                Image(systemName: "xmark")
                    .symbolVariant(.circle.fill)
                    .foregroundStyle(.secondary)
                    .opacity(0.5)
                    .shadow(color: .black.opacity(0.5), radius: 20)
                    .font(.title2)
            }
            .buttonStyle(.squishable)
            .hoverEffect(.lift)
        }
        .font(.title3)
        .padding([.all, .horizontal], 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.systemBackground)
                .shadow(color: .primary.opacity(0.3), radius: 2)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(lineWidth: 1)
                        .foregroundColor(.systemGroupedBackground)
                }
        )
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("The \(term.rawValue) term is \(value.formatted())")
    }

    init(_ term: LinearSystem.Equation.Term, value: Binding<Double>) {
        self.term = term
        self._value = Binding(projectedValue: value)
    }


    func unfocus() {
        if term == .n {
            value = 0
        } else {
            value = 1
        }

        focused.toggle()
    }
}

struct EquationTermTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.systemGroupedBackground.ignoresSafeArea()

            EquationTermTextField(.y, value: .constant(23))
                .padding()
        }
    }
}
