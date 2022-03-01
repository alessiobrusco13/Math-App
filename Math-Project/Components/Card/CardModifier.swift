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
    let onDismiss: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            if isPresented {
                content
                    .overlay(.ultraThinMaterial)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isPresented.toggle()
                            onDismiss()
                        }
                    }

                Card(content: cardContent, accessory: accessoryContent)
                .transition(.move(edge: .bottom))
            } else {
                content
            }
        }
    }

    init(
        isPresented: Binding<Bool>,
        @ViewBuilder cardContent: @escaping () -> CardContent,
        @ViewBuilder accessoryContent: @escaping () -> AccessoryContent,
        onDismiss: @escaping () -> Void
    ) {
        self._isPresented = Binding(projectedValue: isPresented)
        self.cardContent = cardContent
        self.accessoryContent = accessoryContent
        self.onDismiss = onDismiss
    }
}

extension View {
    func card<CardContent: View, AccessoryContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> CardContent,
        @ViewBuilder accessoryView: @escaping () -> AccessoryContent = { EmptyView() as! AccessoryContent },
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(isPresented: isPresented, cardContent: content, accessoryContent: accessoryView, onDismiss: onDismiss))
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
