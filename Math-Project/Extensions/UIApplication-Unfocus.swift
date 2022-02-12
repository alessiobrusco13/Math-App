//
//  UIApplication-Unfocus.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 22/09/2021.
//

import SwiftUI

extension UIApplication {
    func unfocus() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
