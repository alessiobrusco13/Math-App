//
//  Binding-OnChange.swift
//  Binding-OnChange
//
//  Created by Alessio Garzia Marotta Brusco on 13/08/2021.
//

import SwiftUI

extension Binding {
    /// Calls a function when a Binding's wrapped value gets updated.
    /// - Parameter handler: A closure marked with `@escaping` run when the Binding's wrapped value value changes.
    /// - Returns: Returns the given Binding.
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }

    /// Calls a function when a Binding's wrapped value gets updated.
    /// - Parameter handler: A closure, with the new value as its parameter, marked with `@escaping`
    /// run when the Binding's wrapped value value changes.
    /// - Returns: Returns the given Binding.
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
