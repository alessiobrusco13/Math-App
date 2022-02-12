//
//  RecentsView.swift
//  RecentsView
//
//  Created by Alessio Garzia Marotta Brusco on 26/08/2021.
//

import SwiftUI

struct RecentsView: View {
    var body: some View {
        List {
            ForEach(1..<21) { i in
                Text("Recent Equation #\(i)")
            }
            .navigationTitle("Recents")
        }
    }
}

struct RecentsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentsView()
    }
}
