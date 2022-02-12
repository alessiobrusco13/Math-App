//
//  CardView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 26/10/2021.
//

import SwiftUI

struct Card<Content: View, AccessoryContent: View>: View {
    enum AngleDirection {
        case increasing, decreasing
    }

    @ViewBuilder let content: () -> Content
    @ViewBuilder let accessory: () -> AccessoryContent

    @State private var angleOffset = 0.0
    @State private var angleDirection = AngleDirection.increasing

    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.systemBackground)
                .frame(maxWidth: 300, maxHeight: 300)
                .shadow(color: .black.opacity(0.3), radius: 25)

            content()
                .foregroundStyle(.primary)
        }
        .hoverEffect(.lift)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .rotation3DEffect(angle, axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(angle, axis: (x: 0, y: 1, z: 0))
        .overlay(
            accessory()
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom)
        )
        .onReceive(timer) { _ in
            withAnimation {
                update()
            }
        }
    }

    var angle: Angle {
        Angle.degrees(angleOffset)
    }

    func update() {
        let maxOffset = 15.0
        let minOffset = -15.0

        if angleOffset == maxOffset { angleDirection = .decreasing }
        if angleOffset == minOffset { angleDirection = .increasing }

        if angleDirection == .increasing {
            angleOffset += 1
        } else {
            angleOffset -= 1
        }
    }
}
