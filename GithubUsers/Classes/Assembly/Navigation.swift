//
//  Navigation.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation
import UIKit

public class Navigation {
    
    public static let shared = Navigation()
    
    init() {
        configureDefaultViews()
        SplashConfigurator.shared.delegate = self
        ListingConfigurator.shared.delegate = self
    }
    
    private func configureDefaultViews() {
        let attributes = [NSAttributedString.Key.foregroundColor: R.color.fontColor(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold)]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        UINavigationBar.appearance().barTintColor = R.color.navigationBarColor()
        UINavigationBar.appearance().tintColor = R.color.themeColor()
    }
    
    public func buildSplashViewModule() -> UIViewController {
        return SplashConfigurator.shared.createSplashScene()
    }
}
