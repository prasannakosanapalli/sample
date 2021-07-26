//
//  UIApplication+Extension.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import UIKit

extension UIApplication {

    /// Make a blurring effect on the screen which is being captured at the background
    /// - Parameter style: Regular style
    func blurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var screen = appDelegate.screen!
        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        screen.addSubview(blurBackground)
        blurBackground.frame = (screen.frame)
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        window?.addSubview(screen)
    }
    
    /// Removing the blur effect when user moves to foreground
    func removeBlurScreen() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let screen = appDelegate.screen ?? nil
        if screen != nil {
            screen?.removeFromSuperview()
        }
    }
}


@available(iOS 13.0, *)
extension UIScene {
    
    /// Make a blurring effect on the screen which is being captured at the background
    /// - Parameter style: Regular style
    func blurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
        let sceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate)! as! SceneDelegate
        var screen = sceneDelegate.screen ?? nil
        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        screen?.addSubview(blurBackground)
        screen?.tag = kSnapshotViewTag
        blurBackground.frame = (screen?.frame)!
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        window?.addSubview(screen!)
    }

    /// Removing the blur effect when user moves to foreground
    func removeBlurScreen() {
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })! as UIWindow
        let screen = window.viewWithTag(kSnapshotViewTag)
        if screen != nil {
            screen?.removeFromSuperview()
        }
    }
}
