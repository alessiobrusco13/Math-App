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

    var body: some View {
        HStack(spacing: 0) {
            if let first = calculator.currentResult.first, first == "-" {
                Image(systemName: "minus")
                    .scaleEffect(0.6)
            }

            Text(formatted)
                .lineLimit(1)
        }
        .font(.system(size: size).bold())
    }

    var formatted: String {
        if calculator.currentResult.isEmpty == false {
            return abs(Double(calculator.currentResult) ?? 0).formatted()
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
