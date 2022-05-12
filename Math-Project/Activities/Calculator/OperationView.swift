//
//  CalculationView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 09/04/22.
//

import SwiftUI

extension Character {
    fileprivate var isImageTag: Bool {
        (self == "~") ? true : false
    }

    fileprivate var isViewTag: Bool {
        (self == "´") ? true : false
    }

    fileprivate var isTag: Bool {
        guard isImageTag || isViewTag else { return false }
        return true
    }
}

extension String {
    fileprivate var id: UUID { UUID() }

    fileprivate func removeTags() -> String {
        guard let first = first, let last = last,
              first.isTag, last.isTag
        else {
            return self
        }

        var copy = self
        copy.removeFirst()
        copy.removeLast()

        return copy
    }

    fileprivate var isImage: Bool {
        guard let first = first, let last = last else { return false }
        guard first.isImageTag && last.isImageTag else { return false }
        return true
    }

    fileprivate var isView: Bool {
        guard let first = first, let last = last else { return false }
        guard first.isViewTag && last.isViewTag else { return false }
        return true
    }

    fileprivate func systemImageName() -> String {
        let noTags = removeTags()

        if noTags == "multiply" {
            return "circle.fill"
        }

        return noTags
    }

    @ViewBuilder
    fileprivate func view() -> some View {
        let noTags = removeTags()

        switch noTags {
        case "fraction":
            fatalError()

        default:
            fatalError()
        }
    }

}

struct OperationView: View {
    @ObservedObject var calculator: Calculator

    var body: some View {
        HStack(spacing: 0) {
            if calculator.isClear {
                Text(" ")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            ForEach(calculator.currentOperation, id: \.id) { str in
                content(str: str)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    func content(str: String) -> some View {
        if str.isImage {
            if str.contains("multiply") {
                MultiplyView.dot
                    .font(font.bold())
            } else {
                Image(systemName: str.systemImageName())
                    .scaleEffect(0.6)
                    .font(font.bold())
            }
        } else {
            Text(str)
                .fontWeight(.semibold)
                .font(font)
        }
    }

    var font: Font {
        calculator.currentOperation.count >= 15
        ? .system(size: 500/Double(calculator.currentOperation.count))
        : .title
    }
}

struct OperationView_Previews: PreviewProvider {
    static var previews: some View {
        OperationView(calculator: Calculator())
    }
}
