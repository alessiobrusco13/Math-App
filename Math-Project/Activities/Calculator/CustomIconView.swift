//
//  CustomIconView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 01/05/22.
//

import SwiftUI

struct CustomIconView: View {
    let customIcon: CalculatorButton.CustomIcon

    var body: some View {
        switch customIcon {
        case .fraction:
            FractionView.icon
        }
    }
}

struct CustomIconView_Previews: PreviewProvider {
    static var previews: some View {
        CustomIconView(customIcon: .fraction)
    }
}
