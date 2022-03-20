//
//  GraphView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import SwiftUI

struct GraphView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            GraphViewCompact()
        } else {
            GraphViewRegular()
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GraphView()
        }
    }
}
