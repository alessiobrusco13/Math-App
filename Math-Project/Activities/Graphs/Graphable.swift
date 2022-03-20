//
//  Graphable.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 20/03/22.
//

import SwiftUI

protocol Graphable {
    var laText: String { get set }
    func parse()

    func y(x: Double) -> Double
    func point(x: Double, y: Double, size: CGSize) -> CGPoint
    func points(for size: CGSize) -> [CGPoint]
    func path(for size: CGSize) -> Path
}
