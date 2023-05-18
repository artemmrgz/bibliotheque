//
//  BaseViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 17/05/2023.
//

import UIKit
import SPAlert

class BaseViewController: UIViewController {
    
    func displaySPAlert(title: String, message: String? = nil, preset: SPAlertIconPreset, haptic: SPAlertHaptic, completion: (() -> Void)? = nil) {
        let alertView = SPAlertView(title: title, message: message, preset: preset)
        
        if haptic == .error {
            alertView.dismissInTime = false
        }
        styleAlertView(alertView)
        alertView.present(haptic: haptic, completion: completion)
    }
    
    private func styleAlertView(_ alertView: SPAlertView) {
        alertView.titleLabel?.textColor = Resources.Color.textNavy
        alertView.subtitleLabel?.textColor = Resources.Color.textNavy
        alertView.iconView?.tintColor = Resources.Color.textNavy
        alertView.layout.iconSize = .init(width: 100, height: 100)
        alertView.layout.margins.top = 32
    }
}
