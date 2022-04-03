//
//  CardView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 26/10/2021.
//

import SwiftUI

struct Card<Front: View, Back: View, FrontAccessory: View, ButtomAccessory: View>: View {
    @Binding var isFlipped: Bool

    @ViewBuilder let front: () -> Front
    @ViewBuilder let back: () -> Back
    @ViewBuilder let frontAccessory: () -> FrontAccessory
    @ViewBuilder let bottomAccessory: () -> ButtomAccessory

    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        GeometryReader { geo in
            ZStack {
                front()
                    .background(frontBackground(geo: geo))
                    .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .opacity(isFlipped ? 0 : 1)
                    .accessibility(hidden: isFlipped)

                back()
                    .background(background(geo: geo))
                    .rotation3DEffect(.degrees(isFlipped ? 0 : -180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .opacity(isFlipped ? 1 : -1)
                    .accessibility(hidden: !isFlipped)
            }
            .hoverEffect(.lift)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                bottomAccessory()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom)
            }
        }
    }

    var widthMultiplier: Double {
        if sizeClass == .compact {
            return 0.92
        } else {
            return 0.5
        }
    }

    func background(geo: GeometryProxy) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.systemBackground)
            .frame(
                width: geo.frame(in: .local).width * widthMultiplier,
                height: geo.frame(in: .local).height * 0.5
            )
            .shadow(color: .black.opacity(0.3), radius: 25)
    }

    func frontBackground(geo: GeometryProxy) -> some View {
        background(geo: geo)
            .overlay(alignment: .topTrailing) {
                frontAccessory()
                    .padding()
            }

    }
}

fileprivate struct TestView: View {
    @State private var isFlipped = false

    var body: some View {
        Card(isFlipped: $isFlipped) {
            Text(verbatim: "HELLO")
        } back: {
            LinearSystemView(linearSystem: .example)
        } frontAccessory: {
            Text(verbatim: "Text")
        } bottomAccessory: {
            Button(String("heolo")) {
                withAnimation {
                    isFlipped.toggle()
                }
            }
        }
    }
}

struct CardTest_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
