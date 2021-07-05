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
        let toast = UILabel(frame:
                CGRect(x: view.frame.size.width/2 - 150,
                       y: view.frame.size.height - 100,
                       width: 300, height: 100))
        view.addSubview(toast)
        toast.backgroundColor = .darkGray
        toast.font = .systemFont(ofSize: 16)
        toast.numberOfLines = 0
        toast.textAlignment = .center
        toast.textColor = .white
        toast.text = message
        toast.alpha = 1.0
        toast.layer.cornerRadius = 15
        toast.clipsToBounds = true
        self.animations.fadeOut(label: toast, duration: 1.75)
    }
}
