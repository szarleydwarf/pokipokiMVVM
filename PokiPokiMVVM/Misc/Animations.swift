//
//  Animations.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 22/04/2021.
//

import Foundation

import UIKit

protocol AnimationProtocol {
    func fade(_ duration: CFTimeInterval, _ reverse: Bool,
              _ animatonName: CAMediaTimingFunctionName) -> CATransition
    func scale(_ duration: CFTimeInterval) -> CASpringAnimation
}

extension AnimationProtocol {
    func fade(_ duration: CFTimeInterval = 0.75, _ reverse: Bool = false,
              _ animatonName: CAMediaTimingFunctionName = .easeIn) -> CATransition {
        return fade(duration, reverse, animatonName)
    }
    func scale(_ duration: CFTimeInterval = 0.75) -> CASpringAnimation {
        return scale(duration)
    }
}

class Animations: AnimationProtocol {
    func fadeOut(label: UILabel, duration: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: duration) {
                label.alpha = 0
            }
        }
    }

    func fade(_ duration: CFTimeInterval = 0.75, _ reverse: Bool = false,
              _ animatonName: CAMediaTimingFunctionName = .easeIn) -> CATransition {
        let anim = CATransition()
        anim.timingFunction = CAMediaTimingFunction(name: animatonName)
        anim.type = .fade
        anim.subtype = .fromTop
        anim.duration = duration
        anim.autoreverses = reverse
        return anim
    }

    func scale(_ duration: CFTimeInterval = 0.75) -> CASpringAnimation {
        let scaleLayout = CASpringAnimation(keyPath: "transform.scale")
        scaleLayout.damping = 10
        scaleLayout.mass = 0.6
        scaleLayout.initialVelocity = 25
        scaleLayout.stiffness = 150.0
        scaleLayout.fromValue = 2.0
        scaleLayout.toValue = 1.0
        scaleLayout.duration = duration
        return scaleLayout
    }
}
