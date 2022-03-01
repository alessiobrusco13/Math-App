//
//  SolveLinearSystemView.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import SwiftUI

struct SolveLinearSystemView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    @StateObject private var viewModel: ViewModel
    @State private var solutionMethod = SystemSolver.SolutionMethod.gauss

    var body: some View {
        TabView(selection: $solutionMethod) {
            ScrollView {
                testText
                    .foregroundColor(.blue)
            }
            .tag(SystemSolver.SolutionMethod.gauss)

            ScrollView {
                testText
                    .foregroundColor(.red)
            }
            .tag(SystemSolver.SolutionMethod.cramer)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .top) {
            Picker("Solution Method", selection: $solutionMethod.animation()) {
                ForEach(SystemSolver.SolutionMethod.allCases, id: \.self) { method in
                    Text(String(describing: method).capitalized)
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.regularMaterial)
        }
        .overlay(alignment: .bottom) {
            Button {

            } label: {
                Text("Solve")
                    .padding(6)
            }
            .buttonStyle(.bordered)
            .controlSize(.mini)
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
    }

    var testText: some View {
        Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque varius vitae diam sit amet commodo. Suspendisse potenti. Sed lacus odio, ultrices ut magna a, ullamcorper molestie quam. Quisque ullamcorper, orci at lobortis vestibulum, orci leo varius arcu, vitae tempor augue lorem id eros. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacus mi, egestas at ipsum vel, sollicitudin feugiat orci. Nulla ornare ante id magna consectetur, at condimentum elit vulputate. Quisque sit amet dui quis risus accumsan pretium hendrerit eget erat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas commodo elit at metus maximus lacinia. Nunc vestibulum risus blandit ipsum luctus, in tristique libero auctor. Quisque mauris diam, interdum sed arcu ac, tincidunt ornare dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tempus lorem felis, id accumsan purus mollis in. Sed risus ex, eleifend ut consequat a, dictum sit amet justo. Quisque eu quam mollis, aliquam turpis quis, scelerisque tellus."
        )
            .padding(.horizontal)
            .padding(.vertical, 75)
    }

    init(linearSystem: LinearSystem) {
        let model = ViewModel(linearSystem: linearSystem)
        _viewModel = StateObject(wrappedValue: model)
    }
}

struct SolveLinearSystemView_Previews: PreviewProvider {
    static var previews: some View {
        SolveLinearSystemView(linearSystem: .example)
            .previewLayout(.sizeThatFits)
    }
}
