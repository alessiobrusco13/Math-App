//
//  Numeric-Monomials.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 02/04/22.
//

import Foundation

extension FloatLiteralType {
    var x: Monomial { Monomial(self, .x) }
    var sqX: Monomial { Monomial(self, .sqX) }
    var sqrtX: Monomial { Monomial(self, .sqrtX) }

    var y: Monomial { Monomial(self, .y) }
    var sqY: Monomial { Monomial(self, .sqY) }
    var sqrtY: Monomial { Monomial(self, .sqrtY) }
}
