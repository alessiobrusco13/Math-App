//
//  CardModifier.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 30/10/2021.
//

import SwiftUI

private struct CardModifier<Front: View, Back: View, FrontAccessory: View, BottomAccessory: View>: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var isFlipped: Bool

    let front: () -> Front
    let back: () -> Back
    let frontAccessory: () -> FrontAccessory
    let bottomAccessory: () -> BottomAccessory
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

                        withAnimation(.card) {
                            isFlipped.toggle()
                        }
                    }

                Card(
                    isFlipped: $isFlipped,
                    front: front,
                    back: back,
                    frontAccessory: frontAccessory,
                    bottomAccessory: bottomAccessory
                )
                .transition(.move(edge: .bottom))
            } else {
                content
            }
        }
    }

    init(
        isPresented: Binding<Bool>,
        isFlipped: Binding<Bool>,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back,
        @ViewBuilder frontAccessory: @escaping () -> FrontAccessory,
        @ViewBuilder bottomAccessory: @escaping () -> BottomAccessory,
        onDismiss: @escaping () -> Void
    ) {
        self._isPresented = Binding(projectedValue: isPresented)
        self._isFlipped = isFlipped
        self.front = front
        self.back = back
        self.frontAccessory = frontAccessory
        self.bottomAccessory = bottomAccessory
        self.onDismiss = onDismiss
    }
}

extension View {
    func card<Front: View, Back: View, FrontAccessory: View, BottomAccessoryContent: View>(
        isPresented: Binding<Bool>,
        isFlipped: Binding<Bool>,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back,
        @ViewBuilder frontAccessory: @escaping () -> FrontAccessory,
        @ViewBuilder bottomAccessory: @escaping () -> BottomAccessoryContent,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(
            isPresented: isPresented,
            isFlipped: isFlipped,
            front: front,
            back: back,
            frontAccessory: frontAccessory,
            bottomAccessory: bottomAccessory,
            onDismiss: onDismiss
        ))
    }

    func card<Front: View, Back: View, FrontAccessory: View>(
        isPresented: Binding<Bool>,
        isFlipped: Binding<Bool>,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back,
        @ViewBuilder frontAccessory: @escaping () -> FrontAccessory,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(
            isPresented: isPresented,
            isFlipped: isFlipped,
            front: front,
            back: back,
            frontAccessory: frontAccessory,
            bottomAccessory: { EmptyView() },
            onDismiss: onDismiss
        ))
    }

    func card<Front: View, Back: View, BottomAccessory: View>(
        isPresented: Binding<Bool>,
        isFlipped: Binding<Bool>,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back,
        @ViewBuilder bottomAccessory: @escaping () -> BottomAccessory,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(
            isPresented: isPresented,
            isFlipped: isFlipped,
            front: front,
            back: back,
            frontAccessory: { EmptyView() },
            bottomAccessory: bottomAccessory,
            onDismiss: onDismiss
        ))
    }

    func card<Front: View, Back: View>(
        isPresented: Binding<Bool>,
        isFlipped: Binding<Bool>,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(CardModifier(
            isPresented: isPresented,
            isFlipped: isFlipped,
            front: front,
            back: back,
            frontAccessory: { EmptyView() },
            bottomAccessory: { EmptyView() },
            onDismiss: onDismiss
        ))
    }
}


private struct ModifierTestView: View {
    @State private var showingCard = false
    @State private var cardFlipped = false

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
        .card(isPresented: $showingCard, isFlipped: $cardFlipped) {
            Text("Test")
        } back: {
            Text("HEllo")
        } frontAccessory: {
            Button {

            } label: {
                Image(systemName: "info")
                    .symbolVariant(.circle)
                    .font(.title3)
            }
        } bottomAccessory: {
            Button("Hello") {
                withAnimation(.card) {
                    cardFlipped.toggle()
                }
            }
        }
    }
}

struct ModifierTestView_Previews: PreviewProvider {
    static var previews: some View {
        ModifierTestView()
    }
}
