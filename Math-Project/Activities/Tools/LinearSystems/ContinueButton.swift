//
//  ContinueButton.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 25/09/2021.
//

import SwiftUI

struct ContinueButton: View {
    let title: LocalizedStringKey
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: 350)
        }
        .controlSize(.large)
        .buttonStyle(.borderedProminent)
        .transition(.asymmetric(insertion: .scale.combined(with: .slide), removal: .move(edge: .bottom)))
    }
}

struct ContinueButton_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButton(title: "Continue") { }
    }
}
