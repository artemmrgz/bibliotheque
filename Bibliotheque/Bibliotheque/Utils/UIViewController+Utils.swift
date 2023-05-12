//
//  UIViewController+Utils.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 12/04/2023.
//

import UIKit
import SPAlert

extension UIViewController {
    func setTabBarImage(imageName: String, title: String, tag: Int) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }

    private func styleAlertView(_ alertView: SPAlertView, haptic: SPAlertHaptic) {
        alertView.titleLabel?.textColor = Resources.Color.textNavy
        alertView.subtitleLabel?.textColor = Resources.Color.textNavy
        alertView.iconView?.tintColor = Resources.Color.textNavy
        alertView.layout.iconSize = .init(width: 100, height: 100)
        alertView.layout.margins.top = 32
        
        if haptic == .error {
            alertView.dismissInTime = false
        }
    }
    
    func displaySPAlert(title: String, message: String? = nil, preset: SPAlertIconPreset, haptic: SPAlertHaptic, completion: (() -> Void)? = nil) {
        let alertView = SPAlertView(title: title, message: message, preset: preset)
        styleAlertView(alertView, haptic: haptic)
        alertView.present(haptic: haptic, completion: completion)
    }
}
