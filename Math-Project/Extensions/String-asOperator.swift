//
//  String-asOperator.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 01/05/22.
//

import Foundation

extension String {
    func asOperator() -> String {
        switch self {
        case "minus": return "-"
        case "plus": return "+"
        case "multiply": return "*"
        case "divide": return "/"
        case "percent": return "%"
        default: return self
        }
    }
}
