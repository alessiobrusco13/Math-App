//
//  FractionView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 30/04/22.
//

import SwiftUI

struct FractionView: View {
    let rational: Rational

    let numberFont: Font
    let fractFont: Font

    var body: some View {
        VStack(spacing: 0) {
            Text(rational.numerator, format: .number)
                .font(numberFont)

            Image(systemName: "minus")
                .font(fractFont)

            Text(rational.denominator, format: .number)
                .font(numberFont)
        }
    }

    static var icon: some View {
        VStack(spacing: 0) {
            Text(verbatim: "x")

            Image(systemName: "minus")

            Text(verbatim: "y")
                .offset(y: -5)
        }
    }
}

struct FractionView_Previews: PreviewProvider {
    static var previews: some View {
        FractionView(
            rational: Rational(approximating: sqrt(3)),
            numberFont: .title3,
            fractFont: .largeTitle
        )
    }
}
