//
//  AppSidebarNavigation.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 28/09/2021.
//

import SwiftUI

struct AppSidebarNavigation: View {
    @State private var selection: NavigationTag? = .calculator

    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    tag: NavigationTag.calculator,
                    selection: $selection,
                    destination: CalculatorView.init
                ) {
                    Label("Calculator", systemImage: "function")
                }

                NavigationLink(
                    tag: NavigationTag.tools,
                    selection: $selection,
                    destination: ToolsView.init
                ) {
                    Label("Tools", systemImage: "rectangle.3.group")
                }

                NavigationLink(
                    tag: NavigationTag.recents,
                    selection: $selection,
                    destination: RecentsView.init
                ) {
                    Label("Recents", systemImage: "clock")
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("App Name")
        }
    }
}

struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation()
    }
}
