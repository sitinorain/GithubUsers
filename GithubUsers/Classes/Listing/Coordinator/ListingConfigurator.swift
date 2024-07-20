//
//  ListingConfigurator.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit

public class ListingConfigurator {
    public static var shared = ListingConfigurator()
    public weak var delegate: ListingWireframe?

    public func createListingScene() -> UIViewController {
        let userService = UserService()
        let viewController = ListingViewController.fromStoryboard()
        viewController.viewModel = ListingViewModel(userService: userService)
        return viewController
    }
}
