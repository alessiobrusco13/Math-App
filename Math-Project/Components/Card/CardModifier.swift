//
//  CardModifier.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 30/10/2021.
//

import SwiftUI

private struct CardModifier<CardContent: View, AccessoryContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let cardContent: () -> CardContent
    let accessoryContent: () -> AccessoryContent

    func body(content: Content) -> some View {
        ZStack {
            if isPresented {
                content
                    .overlay(.ultraThinMaterial)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isPresented.toggle()
                        }
                    }

                Card(content: cardContent, accessory: accessoryContent)
                .transition(.move(edge: .bottom))
            } else {
                content
            }
        }
    }

    init(isPresented: Binding<Bool>, @ViewBuilder cardContent: @escaping () -> CardContent, @ViewBuilder accessoryContent: @escaping () -> AccessoryContent) {
        self._isPresented = Binding(projectedValue: isPresented)
        self.cardContent = cardContent
        self.accessoryContent = accessoryContent
    }
}

extension View {
    func card<CardContent: View, AccessoryContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> CardContent,
        @ViewBuilder accessoryView: @escaping () -> AccessoryContent
    ) -> some View {
        modifier(CardModifier(isPresented: isPresented, cardContent: content, accessoryContent: accessoryView))
    }

    func card<CardContent: View, ButtonContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> CardContent
    ) -> some View {
        modifier(CardModifier(isPresented: isPresented, cardContent: content, accessoryContent: { EmptyView() }))
    }
}


private struct ModifierTestView: View {
    @State private var showingCard = false

    var body: some View {
        ZStack {
            Color.indigo.ignoresSafeArea()

            VStack {
                Button("Show Card") {
                    withAnimation(.spring()) {
                        showingCard.toggle()
                    }
                }
            }
        }
        .card(isPresented: $showingCard) {
            Text("Hello world")
        } accessoryView: {
            EmptyView()
        }
    }
}

struct ModifierTestView_Previews: PreviewProvider {
    static var previews: some View {
        ModifierTestView()
    }
}
