//
//  Calculator.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 03/04/22.
//

import Foundation
import MathParser
import SwiftUI

class Calculator: ObservableObject {
    @Published var currentOperation = [String]() {
        didSet {
            if !currentOperation.isEmpty {
                isClear = false
            } else {
                isClear = true
            }
        }
    }

    @Published var currentResult = ""
    @Published var isClear = true
    @Published var fractionResults = false

    var proxy: GeometryProxy?

    private let evaluator = Evaluator()
    private var configuration: Configuration

    init() {
        var config = Configuration()
        config.operatorSet = .main
        configuration = config
    }

    func buttons(proxy: GeometryProxy) -> [[CalculatorButton]] { [
        [
            CalculatorButton(text: isClear ? "AC" : "C", action: clear, type: .utility, calculator: self),
            CalculatorButton(customIcon: .fraction, action: toggleMinus, type: .utility, calculator: self),
            CalculatorButton(systemImage: "percent", action: operatorAction, type: .utility, calculator: self),
            CalculatorButton(systemImage: "divide", action: operatorAction, type: .accent, calculator: self)
        ],

        [
            CalculatorButton(text: "7", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(text: "8", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(text: "9", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(systemImage: "multiply", action: operatorAction, type: .accent, calculator: self)
        ],

        [
            CalculatorButton(text: "4", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(text: "5", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(text: "6", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(systemImage: "minus", action: operatorAction, type: .accent, calculator: self)
        ],

        [
            CalculatorButton(text: "1", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(text: "2", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(text: "3", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(systemImage: "plus", action: operatorAction, type: .accent, calculator: self)
        ],

        [
            CalculatorButton(text: "0", action: numberAction, type: .standard, doubleWidth: true, calculator: self),
            CalculatorButton(text: ".", action: numberAction, type: .standard, calculator: self),
            CalculatorButton(systemImage: "equal", action: execute, type: .accent, calculator: self)
        ]
    ] }

    func numberAction(numberStr: String) {
        if currentResult.count < 9 {
            currentResult.append(numberStr)

//            if currentOperation.count >= 18 {
//                currentOperation = [currentResult]
//            } else {
                currentOperation.append(numberStr)
//            }
        }
    }

    func operatorAction(operatorStr: String) {
        currentResult = ""
        currentOperation.append(operatorStr)
    }

    func clear(input: String) {
        currentOperation.removeAll()
        currentResult = ""
    }

    func toggleMinus(input: String) {
        guard let first = currentResult.first else { return }

        if first == "-" {
            currentResult.removeFirst()
        } else {
            currentResult = "-\(currentResult)"
        }
    }

    func backSpace() {
        currentOperation.removeLast()
    }

    func execute(_ input: String) {
        do {
            let expression = try Expression(string: currentOperation.joined(), configuration: configuration)
            currentResult = try evaluator.evaluate(expression).formatted()
        } catch {
            print(error.localizedDescription)
        }
    }
}
