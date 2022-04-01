//
//  Coefficient.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 26/03/22.
//

import Foundation

struct CoefficientFormatStyle: FormatStyle {
    func format(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.alwaysShowsDecimalSeparator = false

        return formatter.string(from: NSNumber(floatLiteral: value)) ?? "Error"
    }
}

extension FormatStyle where Self == CoefficientFormatStyle {
    static var coefficient: CoefficientFormatStyle {
        CoefficientFormatStyle()
    }
}
