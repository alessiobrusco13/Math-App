//
//  OperatorSet-default.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 30/04/22.
//

import MathParser

extension OperatorSet {
    static var main: OperatorSet {
        let opSet = OperatorSet(interpretsPercentSignAsModulo: false)

        opSet.addTokens(["~percent~"], forOperator: Operator(builtInOperator: .percent))
        opSet.addTokens(["~divide~"], forOperator: Operator(builtInOperator: .divide))
        opSet.addTokens(["~multiply~"], forOperator: Operator(builtInOperator: .multiply))
        opSet.addTokens(["~minus~"], forOperator: Operator(builtInOperator: .minus))
        opSet.addTokens(["~minus~"], forOperator: Operator(builtInOperator: .unaryMinus))
        opSet.addTokens(["~plus~"], forOperator: Operator(builtInOperator: .add))
        opSet.addTokens(["~plus~"], forOperator: Operator(builtInOperator: .unaryPlus))
        opSet.addTokens(["~equal~"], forOperator: Operator(builtInOperator: .logicalEqual))

        return opSet
    }
}
