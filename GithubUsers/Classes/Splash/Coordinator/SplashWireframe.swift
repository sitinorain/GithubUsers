//
//  SplashWireframe.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit

public protocol SplashWireframe: AnyObject {
    func navigateToListingViewFromSplash(_ splashViewController: UIViewController)
}

extension Navigation: SplashWireframe {
    public func navigateToListingViewFromSplash(_ splashViewController: UIViewController) {
        guard let fromViewController = splashViewController as? SplashViewController else { return }
        let viewController = ListingConfigurator.shared.createListingScene()
        fromViewController.navigationController?.fadeViewController(viewController: viewController)
    }
}
