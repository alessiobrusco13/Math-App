//
//  ModalSheetController.swift
//  Math-Project
//
//  Created by Alessio Garzia Marotta Brusco on 24/11/2021.
//

import UIKit

class ModalSheetController: UIViewController {
    let detents: [UISheetPresentationController.Detent]
    let grabber: Bool
    let cornerRadius: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let sheetController = self.presentationController as? UISheetPresentationController {
            sheetController.detents = detents
            sheetController.prefersGrabberVisible = grabber
            sheetController.preferredCornerRadius = cornerRadius
        }
    }

    required init?(coder: NSCoder) {
        fatalError("DON'T USE STORYBOARDS")
    }

    init(detents: [UISheetPresentationController.Detent], grabber: Bool = true, cornerRadius: CGFloat? = nil) {
        self.detents = detents
        self.grabber = grabber
        self.cornerRadius = cornerRadius
        super.init(nibName: nil, bundle: nil)
    }
}
