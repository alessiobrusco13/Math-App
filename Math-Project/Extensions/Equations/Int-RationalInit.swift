//
//  Int-RationalInit.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 22/03/22.
//

import Foundation

extension Int {
    init?(_ rational: Rational) {
        if rational.denominator == 1 {
            self = rational.numerator
        } else {
            return nil
        }
    }
}
