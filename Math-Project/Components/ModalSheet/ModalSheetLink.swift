//
//  ModalSheetLink.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import SwiftUI

extension ModalSheetLink {
    class Coordinator {
        var parent: ModalSheetLink?
        var trigger: UIView?

        @objc public func presentSheet() {
            guard let parent = parent else { return }

            let contentHost = UIHostingController(rootView: parent.content())
            let sheetController = ModalSheetController(
                detents: parent.detents,
                grabber: parent.grabber,
                cornerRadius: parent.cornerRadius
            )

            sheetController.addChild(contentHost)
            sheetController.view.addSubview(contentHost.view)
            contentHost.view.pinToEdgesOf(sheetController.view)
            contentHost.didMove(toParent: sheetController)

            trigger?.window?.rootViewController?.present(sheetController, animated: true)
        }
    }
}

extension ModalSheetLink {
    struct TapView: UIViewRepresentable {
        var coordinator: Coordinator

        func makeUIView(context: Context) -> UIView {
            let view = UIView(frame: .zero)
            view.backgroundColor = .clear

            let tapRecognizer = UITapGestureRecognizer(target: coordinator, action: #selector(coordinator.presentSheet))
            view.addGestureRecognizer(tapRecognizer)

            coordinator.trigger = view
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) { }
    }
}

struct ModalSheetLink<Content: View, Trigger: View>: View {
    var detents: [UISheetPresentationController.Detent] = [.medium(), .large()]
    var grabber = true
    var cornerRadius: CGFloat? = nil

    @ViewBuilder let content: () -> Content
    @ViewBuilder let trigger: () -> Trigger

    var coordinator: Coordinator

    var body: some View {
        trigger()
            .overlay {
                TapView(coordinator: coordinator)
            }
    }

    init(
        detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
        grabber: Bool = true,
        cornerRadius: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder trigger: @escaping () -> Trigger
    ) {
        self.detents = detents
        self.grabber = grabber
        self.cornerRadius = cornerRadius
        self.content = content
        self.trigger = trigger

        coordinator = Coordinator()
        coordinator.parent = self
    }
}

struct Sheet_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.white)
            .frame(width: 300, height: 300)
            .shadow(radius: 5)
            .overlay(alignment: .topTrailing) {
                ModalSheetLink {
                    Text(verbatim: "NICE SHEET")
                } trigger: {
                    Text(verbatim: "Try me")
                }
                .background(.red)
            }
    }
}
