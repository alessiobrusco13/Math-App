//
//  SelectedView.swift
//  SelectedView
//
//  Created by Alessio Garzia Marotta Brusco on 25/08/2021.
//

import SwiftUI

struct SelectedView: View {
    let tool: Tool

    var body: some View {
        switch tool.id {
        case .linearSystemSolver:
            CreateLinearSystemView()
        case .equationSolver:
            Text(tool.id.rawValue)
        }
    }

    init(for tool: Tool) {
        self.tool = tool
    }
}

struct SelectedView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedView(for: Tool.example)
    }
}
