//
//  CalculatorButton.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 03/04/22.
//

import SwiftUI

extension Array: Identifiable where Element == CalculatorButton {
    public var id: UUID { UUID() }
}

public struct CalculatorButton: View, Identifiable {
    public let id = UUID()
    let text: String
    let action: (String) -> Void
    let accent: Bool

    public var body: some View {
        Button {
            action(text)
        } label: {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(accent ? Color.calculatorAccent : Color.calculatorButton)
                .overlay {
                    Text(text)
                        .foregroundColor(accent ? .white : .black)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: 80, maxHeight: 80)
        }
        .foregroundColor(.primary)
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(text: "cos()", action: { _ in }, accent: true)
    }
}
