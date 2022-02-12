//
//  ListToolsView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 28/09/2021.
//

import SwiftUI

struct ListToolsView: View {
    let tools: [Tool]

    var body: some View {
        VStack(spacing: 20) {
            ForEach(tools) { tool in
                NavigationLink {
                    SelectedView(for: tool)
                } label: {
                    ToolView.listItem(tool: tool)
                }
                .buttonStyle(.squishable(fadeOnPress: true))
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(tool.name), \(tool.description)")
            }
        }
        .padding(.bottom)
    }
}

struct VerticalActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ListToolsView(tools: Tool.allTools)
    }
}
