//
//  EquationTextFields.swift
//  EquationTextFields
//
//  Created by Alessio Garzia Marotta Brusco on 31/08/2021.
//

import SwiftUI

struct EquationTextFields: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var focused: FocusState<LinearSystem.EquationPosition?>.Binding?
    let position: LinearSystem.EquationPosition?
    
    @Binding var equation: LinearSystem.Equation
    
    @State private var xTerm: Double
    @State private var yTerm: Double
    @State private var zTerm: Double
    @State private var nTerm: Double
    
    init(equation: Binding<LinearSystem.Equation>) {
        self.focused = nil
        self.position = nil
        
        _equation = Binding(projectedValue: equation)
        
        _xTerm = State(wrappedValue: equation.wrappedValue.xTerm)
        _yTerm = State(wrappedValue: equation.wrappedValue.yTerm)
        _zTerm = State(wrappedValue: equation.wrappedValue.zTerm ?? 0)
        _nTerm = State(wrappedValue: equation.wrappedValue.nTerm)
    }
    
    init(focused: FocusState<LinearSystem.EquationPosition?>.Binding, equation: Binding<LinearSystem.Equation>, position: LinearSystem.EquationPosition) {
        self.focused = focused
        self.position = position
        
        _equation = Binding(projectedValue: equation)
        
        _xTerm = State(wrappedValue: equation.wrappedValue.xTerm)
        _yTerm = State(wrappedValue: equation.wrappedValue.yTerm)
        _zTerm = State(wrappedValue: equation.wrappedValue.zTerm ?? 0)
        _nTerm = State(wrappedValue: equation.wrappedValue.nTerm)
    }

    @ViewBuilder
    var content: some View {
        if let focused = focused, let position = position {
            EquationTermTextField(.x, value: $xTerm.onChange(update))
                .focused(focused, equals: position)
        } else {
            EquationTermTextField(.x, value: $xTerm.onChange(update))
        }

        EquationTermTextField(.y, value: $yTerm.onChange(update))

        if equation.zTerm != nil {
            EquationTermTextField(.z, value: $zTerm.onChange(update))
                .transition(.scale)
        }

        EquationTermTextField(.n, value: $nTerm.onChange(update))
    }
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                content
            }
        } else {
            HStack {
                content
            }
        }
    }
    
    func update() {
        if xTerm == 0 {
            xTerm = 1
        }

        if yTerm == 0 {
            yTerm = 1
        }

        if zTerm == 0 && equation.zTerm != nil {
            zTerm = 1
        }

        equation.xTerm = xTerm
        equation.yTerm = yTerm
        equation.nTerm = nTerm

        if equation.zTerm != nil {
            equation.zTerm = zTerm
        }
    }
}

struct EquationTextFields_Previews: PreviewProvider {
    static var previews: some View {
        EquationTextFields(equation: .constant(LinearSystem.Equation.example))
    }
}
