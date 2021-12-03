//
//  Button.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 02/12/21.
//

import UIKit

class Button: UIButton {
    
    private lazy var selectedFont =  UIFont.boldSystemFont(ofSize: 30)
    private lazy var normalFont = UIFont.systemFont(ofSize: 22)
    
    init(title: String = "Button", tag: Int = 0) {
        super.init(frame: .zero)
        self.configurte(title: title, tag: tag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configurte()
    }
    
    func configurte(title: String = "Button", tag: Int = 0) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(.black, for: .selected)
        self.setTitleColor(.lightGray, for: .normal)
        self.backgroundColor = .clear
        self.tag = tag
    }
    
    override func layoutSubviews() {
        self.updateButtonFont(for: self.state)
        super.layoutSubviews()
    }
    
    private func updateButtonFont(for state: UIControl.State) {
        switch state {
            case .selected:
                self.titleLabel?.font = selectedFont
            case .normal:
                self.titleLabel?.font = normalFont
            default: break
        }
    }
}
