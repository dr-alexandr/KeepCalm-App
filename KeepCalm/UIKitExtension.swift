//
//  UIKitExtension.swift
//  KeepCalm
//
//  Created by Dr.Alexandr on 28.12.2022.
//

import UIKit

extension UILabel {
    static func getDefaultBoldLabel(size: CGFloat = 20) -> UILabel {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .roundedFont(ofSize: size, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 25
        label.layer.shadowColor = UIColor.lightGray.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 5
        return label
    }
}

extension UIButton {
    static func getDefaultButton(text: String = "") -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .roundedFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 5
        return button
    }
    static func getSFButton(sfSymbol: String, isEnabled: Bool = true) -> UIButton {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: sfSymbol, withConfiguration: largeConfig)
        let button = UIButton(type: .system)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 5
        button.isEnabled = isEnabled
        return button
    }
}

extension UIFont {
    static func roundedFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let font: UIFont
        if #available(iOS 13.0, *) {
            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: fontSize)
            } else {
                font = systemFont
            }
        } else {
            font = systemFont
        }
        return font
    }
}

extension UIView {
    static func getMapContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }
    
    static func getDimmedView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }
}

extension UIViewController {
    func resetAnimated(_ responseLabel: UILabel, text: String) {
        UIView.transition(with: responseLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {
            responseLabel.text = text
        }, completion: nil)
    }
}
