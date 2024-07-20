//
//  SplashViewModel.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation
import UIKit

class SplashViewModel: NSObject {
    func navigateToListingView(from: UIViewController) {
        guard let fromViewController = from as? SplashViewController else { return }
        SplashConfigurator.shared.delegate?.navigateToListingViewFromSplash(fromViewController)
    }
}
