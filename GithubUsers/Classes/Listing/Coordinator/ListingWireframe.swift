//
//  ListingWireframe.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit

public protocol ListingWireframe: AnyObject {
    func navigateToDetailsViewFromListing(_ listingViewController: UIViewController, withSelectedUser user: User)
}

extension Navigation: ListingWireframe {
    public func navigateToDetailsViewFromListing(_ listingViewController: UIViewController, withSelectedUser user: User) {
        guard let fromViewController = listingViewController as? ListingViewController else { return }
        let viewController = DetailsConfigurator.shared.createDetailsScene(withSelectedUser: user)
        fromViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
