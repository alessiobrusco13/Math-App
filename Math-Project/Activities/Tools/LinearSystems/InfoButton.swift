//
//  InfoButton.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import SwiftUI

struct InfoButton: View {
    let action: (() -> Void)?

    var body: some View {
        if let action = action {
            Button(action: action) {
                Image(systemName: "info.circle")
                    .font(.title3)
            }
        } else {
            Image(systemName: "info.circle")
                .font(.title3)
                .foregroundColor(.accentColor)
        }
    }

    init(action: (() -> Void)? = nil) {
        self.action = action
    }
}

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton { }
    }
}
