//
//  BackButton.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 25/09/2021.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
        }
        .controlSize(.large)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton { }
    }
}
