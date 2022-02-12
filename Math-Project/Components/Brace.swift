//
//  Brace.swift
//  Brace
//
//  Created by Alessio Garzia Marotta Brusco on 13/08/2021.
//

import SwiftUI
// swiftlint:disable line_length

struct Brace: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        path.move(to: CGPoint(x: 0.00047*width, y: 0.45729*height))
        path.addLine(to: CGPoint(x: 0.00047*width, y: 0.54217*height))
        path.addCurve(to: CGPoint(x: 0.21815*width, y: 0.564*height), control1: CGPoint(x: 0.08925*width, y: 0.54271*height), control2: CGPoint(x: 0.16201*width, y: 0.54999*height))
        path.addCurve(to: CGPoint(x: 0.33004*width, y: 0.6203*height), control1: CGPoint(x: 0.27378*width, y: 0.57787*height), control2: CGPoint(x: 0.3111*width, y: 0.59668*height))
        path.addCurve(to: CGPoint(x: 0.35902*width, y: 0.74284*height), control1: CGPoint(x: 0.34835*width, y: 0.6441*height), control2: CGPoint(x: 0.35842*width, y: 0.68494*height))
        path.addCurve(to: CGPoint(x: 0.36968*width, y: 0.85741*height), control1: CGPoint(x: 0.36024*width, y: 0.80092*height), control2: CGPoint(x: 0.36374*width, y: 0.83892*height))
        path.addCurve(to: CGPoint(x: 0.42764*width, y: 0.9279*height), control1: CGPoint(x: 0.38024*width, y: 0.88689*height), control2: CGPoint(x: 0.39925*width, y: 0.91032*height))
        path.addCurve(to: CGPoint(x: 0.5324*width, y: 0.96998*height), control1: CGPoint(x: 0.45602*width, y: 0.94548*height), control2: CGPoint(x: 0.49094*width, y: 0.9595*height))
        path.addCurve(to: CGPoint(x: 0.69209*width, y: 0.99414*height), control1: CGPoint(x: 0.57437*width, y: 0.98064*height), control2: CGPoint(x: 0.6276*width, y: 0.98864*height))
        path.addCurve(to: CGPoint(x: 0.90681*width, y: height), control1: CGPoint(x: 0.73587*width, y: 0.99804*height), control2: CGPoint(x: 0.80752*width, y: height))
        path.addLine(to: CGPoint(x: 1.00394*width, y: height))
        path.addLine(to: CGPoint(x: 1.00394*width, y: 0.9183*height))
        path.addLine(to: CGPoint(x: 0.95008*width, y: 0.9183*height))
        path.addCurve(to: CGPoint(x: 0.71102*width, y: 0.89879*height), control1: CGPoint(x: 0.82996*width, y: 0.9183*height), control2: CGPoint(x: 0.75067*width, y: 0.91174*height))
        path.addCurve(to: CGPoint(x: 0.65244*width, y: 0.81104*height), control1: CGPoint(x: 0.67197*width, y: 0.8858*height), control2: CGPoint(x: 0.65244*width, y: 0.8565*height))
        path.addCurve(to: CGPoint(x: 0.63646*width, y: 0.64607*height), control1: CGPoint(x: 0.65244*width, y: 0.72439*height), control2: CGPoint(x: 0.64712*width, y: 0.66932*height))
        path.addCurve(to: CGPoint(x: 0.52586*width, y: 0.5537*height), control1: CGPoint(x: 0.61811*width, y: 0.60771*height), control2: CGPoint(x: 0.5809*width, y: 0.57681*height))
        path.addCurve(to: CGPoint(x: 0.2898*width, y: 0.49991*height), control1: CGPoint(x: 0.4702*width, y: 0.53081*height), control2: CGPoint(x: 0.39153*width, y: 0.51287*height))
        path.addCurve(to: CGPoint(x: 0.57083*width, y: 0.42425*height), control1: CGPoint(x: 0.42291*width, y: 0.48091*height), control2: CGPoint(x: 0.51638*width, y: 0.45569*height))
        path.addCurve(to: CGPoint(x: 0.65244*width, y: 0.26531*height), control1: CGPoint(x: 0.62527*width, y: 0.39281*height), control2: CGPoint(x: 0.65244*width, y: 0.33989*height))
        path.addCurve(to: CGPoint(x: 0.66071*width, y: 0.14401*height), control1: CGPoint(x: 0.65244*width, y: 0.19766*height), control2: CGPoint(x: 0.65484*width, y: 0.15733*height))
        path.addCurve(to: CGPoint(x: 0.72933*width, y: 0.09535*height), control1: CGPoint(x: 0.66905*width, y: 0.12076*height), control2: CGPoint(x: 0.6915*width, y: 0.1046*height))
        path.addCurve(to: CGPoint(x: 0.95008*width, y: 0.08167*height), control1: CGPoint(x: 0.76665*width, y: 0.08629*height), control2: CGPoint(x: 0.84063*width, y: 0.08167*height))
        path.addLine(to: CGPoint(x: 1.00393*width, y: 0.08167*height))
        path.addLine(to: CGPoint(x: 1.00393*width, y: 0))
        path.addLine(to: CGPoint(x: 0.90681*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.66071*width, y: 0.00834*height), control1: CGPoint(x: 0.79382*width, y: 0), control2: CGPoint(x: 0.71161*width, y: 0.00266*height))
        path.addCurve(to: CGPoint(x: 0.47736*width, y: 0.0467*height), control1: CGPoint(x: 0.58673*width, y: 0.01598*height), control2: CGPoint(x: 0.52586*width, y: 0.02875*height))
        path.addCurve(to: CGPoint(x: 0.38268*width, y: 0.1149*height), control1: CGPoint(x: 0.42886*width, y: 0.06482*height), control2: CGPoint(x: 0.39685*width, y: 0.08753*height))
        path.addCurve(to: CGPoint(x: 0.35901*width, y: 0.24967*height), control1: CGPoint(x: 0.36846*width, y: 0.14241*height), control2: CGPoint(x: 0.36023*width, y: 0.18736*height))
        path.addCurve(to: CGPoint(x: 0.33004*width, y: 0.37897*height), control1: CGPoint(x: 0.35842*width, y: 0.31219*height), control2: CGPoint(x: 0.34834*width, y: 0.35517*height))
        path.addCurve(to: CGPoint(x: 0.21815*width, y: 0.43545*height), control1: CGPoint(x: 0.3111*width, y: 0.40277*height), control2: CGPoint(x: 0.27378*width, y: 0.42159*height))
        path.addCurve(to: CGPoint(x: 0.00047*width, y: 0.45729*height), control1: CGPoint(x: 0.16201*width, y: 0.44929*height), control2: CGPoint(x: 0.08925*width, y: 0.45657*height))
        path.closeSubpath()

        return path
    }
}
