//
//  Coefficient.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 26/03/22.
//

import Foundation

struct CoefficientFormatStyle: FormatStyle {
    func format(_ value: Double) -> String {
        if value == floor(value) {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
}

extension FormatStyle where Self == CoefficientFormatStyle {
    static var coefficient: CoefficientFormatStyle {
        CoefficientFormatStyle()
    }
}
