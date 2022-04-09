//
//  CalculatorView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 30/10/2021.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var calculator = Calculator()
    @State private var disabled = false

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .trailing) {
                ZStack(alignment: .trailing) {
                    ResultView(calculator: calculator)
                        .padding()

                    OperationView(calculator: calculator)
                        .padding(.horizontal)
                        .offset(y: -80)
                }

                Spacer()

                ForEach(calculator.buttons(proxy: proxy)) { row in
                    HStack {
                        ForEach(row) { button in
                            button
                                .buttonStyle(.squishable(fadeOnPress: false))
                                .disabled(
                                    button.type == .standard
                                    ? disabled
                                    : false
                                )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom)
            .onAppear { calculator.proxy = proxy }
        }
    }
}
