//
//  TabBarNavigation.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 28/09/2021.
//

import SwiftUI

struct AppTabNavigation: View {
    @State private var selection = NavigationTag.calculator

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                ToolsView()
            }
            .tag(NavigationTag.tools)
            .tabItem {
                Label("Tools", systemImage: "rectangle.3.group")
            }

            NavigationView {
                RecentsView()
            }
            .tag(NavigationTag.recents)
            .tabItem {
                Label("Recents", systemImage: "clock")
            }
        }
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
