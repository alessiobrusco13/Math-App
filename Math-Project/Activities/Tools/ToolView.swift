//
//  ToolView.swift
//  ToolView
//
//  Created by Alessio Garzia Marotta Brusco on 24/08/2021.
//

import SwiftUI

struct ToolView: View {
    var iconSizeMetric: ScaledMetric<CGFloat>
    let tool: Tool

    private init(tool: Tool, iconSize: CGFloat) {
        self.tool = tool
        self.iconSizeMetric = ScaledMetric(
            wrappedValue: iconSize,
            relativeTo: .largeTitle
        )
    }

    var size: CGFloat {
        iconSizeMetric.wrappedValue
    }

    var body: some View {
        ZStack(alignment: .bottom) { 
            backgroundGradient

            VStack(alignment: .leading, spacing: 30) {
                Text(tool.icon)
                    .font(
                        .system(
                            size: size,
                            weight: .semibold,
                            design: .serif
                        ).italic()
                    )
                    .foregroundStyle(.linearGradient(
                        colors: [.white, .white.opacity(0.3)],
                        startPoint: .trailing,
                        endPoint: .leading
                    ))
                    .shadow(color: .white.opacity(0.2), radius: 10, y: 10)

                VStack(alignment: .leading) {
                    Text(tool.name)
                        .foregroundColor(.primary)
                        .font(.title2)
                        .fontWeight(.medium)

                    Text(tool.description)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(.ultraThickMaterial)
            }
        }
    }

    private var backgroundGradient: some View {
        LinearGradient(color: tool.color)
            .background()
    }

    static func gridItem(tool: Tool) -> some View {
        ToolView(tool: tool, iconSize: 132)
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 250)
            .frame(maxWidth: 250)
            .cornerRadius(16)
            .hoverEffect()
            .padding(.horizontal)
            .shadow(color: .primary.opacity(0.1), radius: 10, y: 5)
    }

    static func listItem(tool: Tool) -> some View {
        ToolView(tool: tool, iconSize: 250)
            .frame(height: 450)
            .frame(maxWidth: 450)
            .cornerRadius(16)
            .padding(.horizontal)
            .shadow(color: .primary.opacity(0.1), radius: 10, y: 16)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ToolView.gridItem(tool: Tool.example)
    }
}
