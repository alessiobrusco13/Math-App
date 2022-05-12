//
//  ResultView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 09/04/22.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var calculator: Calculator
    @ScaledMetric(relativeTo: .largeTitle) var size = 60
    @State private var showingError = false

    var body: some View {
        HStack(spacing: 0) {
            if let first = calculator.currentResult.first, first == "-" {
                Image(systemName: "minus")
                    .scaleEffect(0.6)
            }

            if calculator.fractionResults {
                if result.denominator == 1 {
                    Text(formatted)
                        .lineLimit(1)
                } else {
                    FractionView(rational: abs(result), numberFont: .system(size: size / 2).bold(), fractFont: .system(size: size / 1.5))
                }
            } else {
                Text(formatted)
                    .lineLimit(1)
            }
        }
        .font(.system(size: size).bold())
    }

    var result: Rational {
        if let double = Double(calculator.currentResult) {
            return Rational(approximating: double)
        } else {
            return Rational(0)
        }
    }

    var formatted: String {
        if calculator.currentResult.isEmpty == false {
            return result.double.formatted()
        } else {
            return ""
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(calculator: Calculator())
    }
}
