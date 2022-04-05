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
        ForEach(calculator.buttons) { row in
            Text("")
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
