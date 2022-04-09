//
//  MultiplyView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 09/04/22.
//

import SwiftUI

struct MultiplyView {

    private init() { }

    static var dot: some View {
        Image(systemName: "circle.fill")
            .scaleEffect(0.2)
    }

    static var cross: some View {
        Image(systemName: "multiply")
            .scaleEffect(0.6)
    }
}

struct MultiplyView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplyView.dot
            .font(.largeTitle.bold())
    }
}
