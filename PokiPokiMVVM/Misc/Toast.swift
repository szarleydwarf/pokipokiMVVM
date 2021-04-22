//
//  Toast.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 22/04/2021.
//

import Foundation
import UIKit

class Toast {
    let animations = Animations()

    func displayToast(in view: UIView, message: String) {
        let toast = createSubCenterView(in: view, in: .systemBlue)
        let lab = createSubCenterView(in: toast, in: .systemYellow, with: message)
        toast.addSubview(lab)
        self.animations.fadeOut(label: toast, duration: 1.75)
    }

    func createSubCenterView(in view: UIView, in color: UIColor,
                             with text: String = "") -> UILabel {
        let box = UILabel()
        box.layer.cornerRadius = 10
        view.addSubview(box)
        if !text.isEmpty {
            box.text = text
            box.textAlignment = .center
        }
        box.backgroundColor = color
        return box
    }
}
