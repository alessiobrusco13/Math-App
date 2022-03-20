//
//  GraphEquation.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import SwiftUI

class GraphEquation: ObservableObject, Graphable {
    

    @Published var laText = "" {
        didSet { parse() }
    }

    func parse() {
        guard laText.isEmpty else { return }
    }

    func y(x: Double) -> Double {
        0
    }

    func point(x: Double, y: Double, size: CGSize) -> CGPoint {
        .zero
    }

    func points(for size: CGSize) -> [CGPoint] {
        []
    }

    func path(for size: CGSize) -> Path {
        .init()
    }
}
