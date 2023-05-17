//
//  BaseViewController.swift
//  Bibliotheque
//
//  Created by Artem Marhaza on 17/05/2023.
//

import UIKit
import SPAlert

class BaseViewController: UIViewController {
    lazy var alertView: SPAlertView = {
        let alert = SPAlertView(title: "", message: "", preset: .done)
        alert.titleLabel?.textColor = Resources.Color.textNavy
        alert.subtitleLabel?.textColor = Resources.Color.textNavy
        alert.iconView?.tintColor = Resources.Color.textNavy
        alert.layout.iconSize = .init(width: 100, height: 100)
        alert.layout.margins.top = 32
        return alert
    }()
    
    func displaySPAlert(title: String, message: String? = nil, preset: SPAlertIconPreset, haptic: SPAlertHaptic, completion: (() -> Void)? = nil) {

        if haptic == .error {
            alertView.dismissInTime = false
        }
        
        alertView.titleLabel?.text = title
        alertView.subtitleLabel?.text = message
        alertView.layout = SPAlertLayout.init(for: preset)
        
        alertView.present(haptic: haptic, completion: completion)
    }
}
