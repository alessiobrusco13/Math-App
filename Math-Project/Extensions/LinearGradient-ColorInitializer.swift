//
//  LinearGradient-ColorsInitializer.swift
//  LinearGradient-ColorsInitializer
//
//  Created by Alessio Garzia Marotta Brusco on 24/08/2021.
//

import SwiftUI

extension LinearGradient {
    init(color: Color) {
        self.init(colors: [color, color.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
