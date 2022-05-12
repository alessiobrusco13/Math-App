//
//  ButtonToggle.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 01/05/22.
//

import SwiftUI

struct ButtonToggle<Content: View>: View {
    @Binding var isOn: Bool
    @ViewBuilder let label: () -> Content

    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            label()
        }
        .buttonStyle(.bordered)
        .tint(isOn ? .accentColor : .gray)
    }
}

struct ButtonToggle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonToggle(isOn: .constant(false)) {
            Text("H")
        }
    }
}
