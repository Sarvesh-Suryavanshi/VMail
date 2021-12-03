//
//  ViewBuilder.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 02/12/21.
//

import Foundation
import UIKit

/// View Factory
class ViewBuilder {
    
    private init() { }
    
    class func createAppTabBar() -> UITabBarController {
        let tabViewController = UITabBarController()
        let emailView = ViewBuilder.createTabBarChildView(type: .mailBox)
        let composeEmailView = ViewBuilder.createTabBarChildView(type: .newMail)
        let searchView = ViewBuilder.createTabBarChildView(type: .searchMail)
        tabViewController.setViewControllers([emailView, composeEmailView, searchView], animated: true)
        tabViewController.tabBar.tintColor = .black
        return tabViewController
    }
    
    class func emailDetailView() -> EmailDetailViewController? {
        let storyboard = UIStoryboard(name: "VMail", bundle: .main)
        let view = storyboard.instantiateViewController(withIdentifier: "EmailDetailViewController") as? EmailDetailViewController
        return view
    }
}

// MARK: - Private Methods

private extension ViewBuilder {
    
    enum TabChildViewType: String  {
        
        case mailBox = "Email"
        case newMail = "To Write"
        case searchMail = "Search"
        
        fileprivate func view() -> UINavigationController {
            let icons = self.icons
            let tabBarItem = UITabBarItem(title: self.rawValue, image: icons.0, selectedImage: icons.1)
            switch self {
            case .mailBox:
                let viewModel = EmailViewModel()
                let view = EmailViewController(viewModel: viewModel)
                view.title = tabBarItem.title
                view.tabBarItem = tabBarItem
                return view.embedInNavigationController()
            case .newMail:
                let view = ComposeEmailViewController()
                view.title = tabBarItem.title
                view.tabBarItem = tabBarItem
                return view.embedInNavigationController()
            case .searchMail:
                let view = SearchViewController()
                view.title = tabBarItem.title
                view.tabBarItem = tabBarItem
                return view.embedInNavigationController()

            }
        }
        
        private var icons: (UIImage?, UIImage?) {
            let iconImageName = self.iconImageName
            return (UIImage(named: iconImageName.0), UIImage(named: iconImageName.1))
        }
        
        private var iconImageName: (String, String) {
            switch self {
            case .mailBox:
                return ("mailbox","mailbox")
            case .newMail:
                return ("newEmail","newEmail_filled")
            case .searchMail:
                return ("search","search_filled")
            }
        }
    }
    
    class func createTabBarChildView(type: TabChildViewType) -> UINavigationController {
        return type.view()
    }
}
