//
//  CalculationView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 09/04/22.
//

import SwiftUI

extension String {
    fileprivate var id: UUID { UUID() }

    fileprivate var isImage: Bool {
        guard let first = first, let last = last else { return false }

        if first == "~" && last == "~" {
            return true
        }

        return false
    }

    fileprivate func systemImageName() -> String {
        var copy = self
        copy.removeFirst()
        copy.removeLast()

        if copy == "multiply" {
            return "circle.fill"
        }

        return copy
    }
}

struct OperationView: View {
    @ObservedObject var calculator: Calculator

    var body: some View {
        HStack(spacing: 0) {
            if calculator.isClear {
                Text(" ")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            ForEach(calculator.currentOperation, id: \.id) { str in
                content(str: str)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    func content(str: String) -> some View {
        if str.isImage {
            if str.contains("multiply") {
                MultiplyView.dot
                    .font(font.bold())
            } else {
                Image(systemName: str.systemImageName())
                    .scaleEffect(0.6)
                    .font(font.bold())
            }
        } else {
            Text(Double(str) ?? 0, format: .number)
                .fontWeight(.semibold)
                .font(font)
        }
    }

    var font: Font {
        calculator.currentOperation.count >= 15
        ? .system(size: 500/Double(calculator.currentOperation.count))
        : .title
    }
}

struct OperationView_Previews: PreviewProvider {
    static var previews: some View {
        OperationView(calculator: Calculator())
    }
}
