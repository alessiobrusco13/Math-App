//
//  ModalSheetLink.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import SwiftUI

struct ModalSheetLink<Content: View>: UIViewRepresentable {
    let label: String
    var detents: [UISheetPresentationController.Detent] = [.medium(), .large()]
    var grabber = true
    var cornerRadius: CGFloat? = nil

    @ViewBuilder let content: () -> Content

    func makeUIView(context: Context) -> some UIView {
        let button = UIButton()

        var config = UIButton.Configuration.borderedProminent()
        config.title = label
        config.buttonSize = .large
        button.configuration = config

        let action = UIAction { _ in
            let hostingController = UIHostingController(rootView: content())
            let sheetController = ModalSheetController(detents: detents, grabber: grabber, cornerRadius: cornerRadius)

            sheetController.addChild(hostingController)
            sheetController.view.addSubview(hostingController.view)
            hostingController.view.pinToEdgesOf(sheetController.view)
            hostingController.didMove(toParent: sheetController)

            button.window?.rootViewController?.present(sheetController, animated: true)
        }

        button.addAction(action, for: .touchUpInside)

        return button
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
