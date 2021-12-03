//
//  UIComponants.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 02/12/21.
//

import UIKit

class UI {
    
    private init() {}
    
    class func VStack(childrens: [UIView]? = nil,
                      distribution: UIStackView.Distribution = .fillEqually,
                      spacing: CGFloat = 0.0) -> UIStackView {
        let stackView = UI.createStackView(childrens: childrens, distribution: distribution, spacing: spacing)
        stackView.axis = .vertical
        return stackView
    }
    
    class func HStack(childrens: [UIView]? = nil,
                      distribution: UIStackView.Distribution = .fillEqually,
                      spacing: CGFloat = 0.0) -> UIStackView {
        let stackView = UI.createStackView(childrens: childrens, distribution: distribution, spacing: spacing)
        stackView.axis = .horizontal
        return stackView
    }
    
    class var seperator: UIView {
        let separatorView = UIView(frame: .zero)
        separatorView.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        separatorView.backgroundColor = .lightGray
        return separatorView
    }
    
    class var spacer: UIView {
        let spacerView = UIView(frame: .zero)
        spacerView.backgroundColor = .clear
        return spacerView
    }
}

// MARK: - Private Methods

extension UI {
    
    private class func createStackView(childrens: [UIView]? = nil,
                                 distribution: UIStackView.Distribution = .fillEqually,
                                       spacing: CGFloat = 0.0) -> UIStackView {
        
        // Creating new stack view with basic properties here
        let stackView = UIStackView()
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding child views here if any
        guard let childrens = childrens else {
            return stackView
        }
        childrens.forEach { childView in
            stackView.addArrangedSubview(childView)
        }
        return stackView
    }
}
