//
//  Calculator.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 03/04/22.
//

import Foundation

class Calculator: ObservableObject {
    typealias Button = CalculatorButton

    @Published var currentOperation = ""

    lazy var buttons: [[CalculatorButton]] = { [
        [
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false)
        ],

        [
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false)
        ],

        [
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false),
            CalculatorButton(text: "7", action: numberAction, accent: false)
        ]
    ] }()

    func numberAction(number: String) {
        currentOperation += number
    }
}
