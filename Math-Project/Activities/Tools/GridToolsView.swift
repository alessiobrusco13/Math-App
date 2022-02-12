//
//  GridToolsView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 28/09/2021.
//

import SwiftUI

struct GridToolsView: View {
    let tools: [Tool]

    var columns: [GridItem] {
        [GridItem(.flexible())]
    }

    var body: some View {
        LazyHGrid(rows: columns) {
            ForEach(tools) { tool in
                NavigationLink {
                    SelectedView(for: tool)
                } label: {
                    ToolView.gridItem(tool: tool)
                }
                .buttonStyle(.squishable(fadeOnPress: true))
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

struct GridActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        GridToolsView(tools: Tool.allTools)
            .previewDevice("iPad mini (6th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
