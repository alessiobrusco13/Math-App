//
//  OrderedSet.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 21/12/2021.
//

import Foundation

struct OrderedSet<Element: Hashable>: RandomAccessCollection {
    private(set) var array = [Element]()
    private var set = Set<Element>()

    init() {

    }

    init(array: [Element]) {
        for element in array {
            append(element)
        }
    }

    subscript(position: Int) -> Element {
        array[position]
    }

    var startIndex: Int { array.startIndex }
    var endIndex: Int { array.endIndex }

    @discardableResult
    mutating func append(_ newMember: Element) -> Bool {
        if set.insert(newMember).inserted {
            array.append(newMember)

            return true
        } else {
            return false
        }
    }

    func contains(_ member: Element) -> Bool {
        set.contains(member)
    }
}

extension OrderedSet: Equatable {
    static func ==(lhs: OrderedSet, rhs: OrderedSet) -> Bool {
        lhs.array == lhs.array
    }
}
