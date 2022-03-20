//
//  CardModifier.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 30/10/2021.
//

import SwiftUI

private struct CardModifier<CardContent: View, TopAccessoryContent: View, BottomAccessoryContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let cardContent: () -> CardContent
    let topAccessoryContent: () -> TopAccessoryContent
    let bottomAccessoryContent: () -> BottomAccessoryContent
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

                Card(
                    content: cardContent,
                    topAccessory: topAccessoryContent,
                    bottomAccessory: bottomAccessoryContent
                )
                .transition(.move(edge: .bottom))
            } else {
                content
            }
        }
    }

    init(
        isPresented: Binding<Bool>,
        @ViewBuilder cardContent: @escaping () -> CardContent,
        @ViewBuilder topAccessory: @escaping () -> TopAccessoryContent,
        @ViewBuilder bottomAccessory: @escaping () -> BottomAccessoryContent,
        onDismiss: @escaping () -> Void
    ) {
        self._isPresented = Binding(projectedValue: isPresented)
        self.cardContent = cardContent
        self.topAccessoryContent = topAccessory
        self.bottomAccessoryContent = bottomAccessory
        self.onDismiss = onDismiss
    }
}

extension View {
    func card<CardContent: View, TopAccessoryContent: View, BottomAccessoryContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> CardContent,
        @ViewBuilder topAccessory: @escaping () -> TopAccessoryContent,
        @ViewBuilder bottomAccessory: @escaping () -> BottomAccessoryContent,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(
            isPresented: isPresented,
            cardContent: content,
            topAccessory: topAccessory,
            bottomAccessory: bottomAccessory,
            onDismiss: onDismiss
        ))
    }

    func card<CardContent: View, TopAccessoryContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> CardContent,
        @ViewBuilder topAccessory: @escaping () -> TopAccessoryContent,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(
            isPresented: isPresented,
            cardContent: content,
            topAccessory: topAccessory,
            bottomAccessory: { EmptyView() },
            onDismiss: onDismiss
        ))
    }

    func card<CardContent: View, BottomAccessoryContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> CardContent,
        @ViewBuilder bottomAccessory: @escaping () -> BottomAccessoryContent,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(
            isPresented: isPresented,
            cardContent: content,
            topAccessory: { EmptyView() },
            bottomAccessory: bottomAccessory,
            onDismiss: onDismiss
        ))
    }

    func card<CardContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> CardContent,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(
            isPresented: isPresented,
            cardContent: content,
            topAccessory: { EmptyView() },
            bottomAccessory: { EmptyView() },
            onDismiss: onDismiss
        ))
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
            Text("Test")
        } topAccessory: {
            Button {

            } label: {
                Image(systemName: "info")
                    .symbolVariant(.circle)
                    .font(.title3)
            }
        } bottomAccessory: {
            Text("Hello")
        }
    }
}

struct ModifierTestView_Previews: PreviewProvider {
    static var previews: some View {
        ModifierTestView()
    }
}
