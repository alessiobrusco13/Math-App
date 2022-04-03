//
//  Tool.swift
//  Tool
//
//  Created by Alessio Garzia Marotta Brusco on 24/08/2021.
//

import SwiftUI

struct Tool: Identifiable {
    enum Identifier: LocalizedStringKey {
        case linearSystemSolver = "Linear System Solver"
        case equationSolver = "Equation Solver"
    }

    let name: LocalizedStringKey
    let description: LocalizedStringKey
    let icon: String
    let systemImageName: String?
    let color: Color

    var id: Identifier { Identifier(rawValue: name)! }

    static let example = allTools[0]
}

extension Tool {
    static let allTools = [
        Tool(
            name: "Linear System Solver",
            description: "Description...",
            icon: "xy",
            systemImageName: nil,
            color: Color("Gold")
        ),

        Tool(
            name: "Equation Solver",
            description: "Description...",
            icon: "xy",
            systemImageName: nil,
            color: Color("Purple")
        )
    ]
}
