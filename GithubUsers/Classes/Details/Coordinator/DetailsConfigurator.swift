//
//  DetailsConfigurator.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit

public class DetailsConfigurator {
    public static var shared = DetailsConfigurator()
    public weak var delegate: DetailsWireframe?

    public func createDetailsScene(withSelectedUser user: User) -> UIViewController {
        let userService = UserService()
        let viewController = DetailsViewController.fromStoryboard()
        viewController.viewModel = DetailsViewModel(user: user, userService: userService)
        return viewController
    }
}
