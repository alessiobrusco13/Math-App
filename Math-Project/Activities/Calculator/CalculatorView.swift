//
//  CalculatorView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 30/10/2021.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var calculator = Calculator()

    var body: some View {
        VStack {
            Text(calculator.currentOperation)
            ForEach(calculator.buttons) { row in
                HStack {
                    ForEach(row) { button in
                        button
                            .buttonStyle(.squishable)
                    }
                }
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
