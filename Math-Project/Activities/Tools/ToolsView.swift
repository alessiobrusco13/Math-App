//
//  ToolsView.swift
//  ToolsView
//
//  Created by Alessio Garzia Marotta Brusco on 24/08/2021.
//

import SwiftUI

struct ToolsView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif

    let tools = Tool.allTools

    var body: some View {
        ScrollView {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                ListToolsView(tools: tools)
            } else {
                GridToolsView(tools: tools)
            }
            #else
            GridToolsView(tools: tools)
            #endif
        }
        .navigationTitle("Tools")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}
