//
//  Font-Equation.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 07/01/2022.
//

import SwiftUI

extension Font {
    static func equation(size: CGFloat) -> Font {
        Font.system(size: size, weight: .regular, design: .serif).italic()
    }
}
