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
    enum ButtonType {
        case standard, utility, accent
    }

    enum CustomIcon: String {
        case fraction = "fraction"
    }

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var calculator: Calculator

    public let id = UUID()

    let text: String
    let systemImage: String?
    let customIcon: CustomIcon?

    let action: (String) -> Void
    let type: ButtonType
    let doubleWidth: Bool

    public var body: some View {
        Button {
            action(text)
        } label: {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(color)
                .overlay {
                    content
                    .font(.title.weight(.semibold))
                    .foregroundColor(textColor)

                }
                .frame(maxWidth: doubleWidth ? buttonWidth * 2 : buttonWidth, maxHeight: buttonWidth)
        }
        .foregroundColor(.primary)
    }

    @ViewBuilder
    var content: some View {
        if let systemImage = systemImage {
            Image(systemName: systemImage)
        } else if let customIcon = customIcon {
            CustomIconView(customIcon: customIcon)
        } else {
            Text(text)
        }
    }

    init(
        text: String,
        action: @escaping (String) -> Void,
        type: ButtonType,
        doubleWidth: Bool = false,
        calculator: Calculator
    ) {
        self.text = text
        self.action = action
        self.type = type
        self.doubleWidth = doubleWidth
        self.calculator = calculator
        systemImage = nil
        customIcon = nil
    }

    init(
        systemImage: String,
        action: @escaping (String) -> Void,
        type: ButtonType,
        doubleWidth: Bool = false,
        calculator: Calculator
    ) {
        self.systemImage = systemImage
        self.action = action
        self.type = type
        self.doubleWidth = doubleWidth
        self.calculator = calculator
        text = systemImage.asOperator()
        customIcon = nil
    }

    init(
        customIcon: CustomIcon,
        action: @escaping (String) -> Void,
        type: ButtonType,
        doubleWidth: Bool = false,
        calculator: Calculator
    ) {
        self.customIcon = customIcon
        self.action = action
        self.type = type
        self.doubleWidth = doubleWidth
        self.calculator = calculator
        text = "´\(customIcon.rawValue)´"
        systemImage = nil
    }

    var buttonWidth: Double {
        (calculator.proxy?.frame(in: .global).width ?? 0) / 4.5
    }

    var light: Bool {
        colorScheme == .light
    }

    var color: some ShapeStyle {
        switch type {
        case .standard:
            return light ? Color.calculatorButtonLight : Color.calculatorButtonDark
        case .utility:
            return light ? Color.blue : Color.blue
        case .accent:
            return Color.calculatorAccent
        }
    }

    var textColor: Color {
        switch type {
        case .standard:
            return .primary
        default:
            return .white
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            CalculatorButton(text: "H", action: { _ in }, type: .standard, calculator: Calculator())
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
