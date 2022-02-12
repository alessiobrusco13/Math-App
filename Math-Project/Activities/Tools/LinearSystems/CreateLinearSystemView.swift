//
//  CreateLinearSystemView.swift
//  CreateLinearSystemView
//
//  Created by Alessio Garzia Marotta Brusco on 03/09/2021.
//

import SwiftUI

struct CreateLinearSystemView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject private var viewModel = ViewModel()

    @State private var backShowing = false
    @State private var showingErrorAlert = false
    @State private var showingLinearSystem = false

    @FocusState private var focusedEquation: LinearSystem.EquationPosition?

    var buttonTitle: LocalizedStringKey {
        withAnimation {
            let createCondition = viewModel.selectedEquation == .third || (viewModel.selectedEquation == .second && viewModel.currentEquationNumber == .two)

            if  createCondition {
                return "Create Linear System"
            } else {
                return "Continue"
            }
        }
    }

    var body: some View {
        VStack {
            fields
            buttons
        }
        .navigationTitle("Linear System Solver")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: equationMenu)
        .alert("There was an error creating your linear system. Please, try again.", isPresented: $showingErrorAlert) {
            Button("OK") { }
        }
        .card(isPresented: $showingLinearSystem) {
            LinearSystemView(linearSystem: viewModel.linearSystem)
        } accessoryView: {
            ModalSheetLink(label: "Solve", cornerRadius: 30) {
                SolveLinearSystemView(linearSystem: viewModel.linearSystem)
            }
            .frame(maxWidth: 350, maxHeight: 44)
            .padding(.horizontal)
        }
    }

    var fields: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                CreateSystemEquationView(.first, equation: $viewModel.firstEquation, focused: $focusedEquation)
                    .offset(x: viewModel.selectedEquation == .first ? 0 : -offsetAmount(in: geometry))
                    .offset(x: viewModel.selectedEquation == .third ? -offsetAmount(in: geometry)*2 : 0)
                    .opacity(
                        (horizontalSizeClass == .regular && viewModel.selectedEquation != .first)
                        ? 0
                        : 1
                    )

                CreateSystemEquationView(.second, equation: $viewModel.secondEquation, focused: $focusedEquation)
                    .offset(x: viewModel.selectedEquation == .second ? 0 : offsetAmount(in: geometry))
                    .offset(x: viewModel.selectedEquation == .third ? -offsetAmount(in: geometry)*2 : 0)
                    .opacity(
                        (horizontalSizeClass == .regular && viewModel.selectedEquation != .second)
                        ? 0
                        : 1
                    )

                if viewModel.currentEquationNumber == .three {
                    CreateSystemEquationView(.third, equation: $viewModel.thirdEquation, focused: $focusedEquation)
                        .offset(x: viewModel.selectedEquation == .third ? 0 : offsetAmount(in: geometry)*2)
                        .offset(x: viewModel.selectedEquation == .second ? -offsetAmount(in: geometry) : 0)
                        .opacity(
                            (horizontalSizeClass == .regular && viewModel.selectedEquation != .third)
                            ? 0
                            : 1
                        )
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    var buttons: some View {
        HStack {
            if backShowing {
                BackButton(action: backAction)
            }

            ContinueButton(title: buttonTitle, action: continueAction)

        }
        .padding([.bottom, .horizontal])
    }

    func equationMenu() -> some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            EquationNumberMenu(equationNumber: $viewModel.currentEquationNumber) { number in
                withAnimation {
                    viewModel.changeNumber(to: number)
                    focusedEquation = viewModel.selectedEquation
                }
            }
            .disabled(showingLinearSystem)
        }
    }

    func createLinearSystem() {
        do {
            try viewModel.createLinearSystem()
            withAnimation(.spring()) {
                showingLinearSystem.toggle()
            }
        } catch {
            showingErrorAlert.toggle()
        }
    }

    func backAction() {
        withAnimation(.spring().delay(0.01)) {
            viewModel.goBack()
            toggleButton()
        }

        focusedEquation = viewModel.selectedEquation
    }

    func continueAction() {
        if viewModel.shouldCreateLinearSystem {
            createLinearSystem()
        }

        withAnimation(.spring()) {
            viewModel.switchEquation()
            toggleButton()
        }

        focusedEquation = viewModel.selectedEquation
    }

    func offsetAmount(in proxy: GeometryProxy) -> CGFloat {
        if horizontalSizeClass == .compact {
            return proxy.size.width * 0.8
        } else {
            return proxy.size.width
        }
    }

    func toggleButton() {
        if viewModel.currentEquationNumber == .three {
            if viewModel.selectedEquation == .second || viewModel.selectedEquation == .third {
                backShowing = true
                return
            }
        } else {
            if viewModel.selectedEquation == .second {
                backShowing = true
                return
            }
        }

        backShowing = false
    }
}

struct CreateLinearSystemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateLinearSystemView()
        }
        .navigationViewStyle(.stack)
    }
}
