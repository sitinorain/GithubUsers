//
//  Assembly.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation
import UIKit

protocol AssemblyProtocol: AnyObject {
    func initialScreen() -> UIViewController
}

public class Assembly: AssemblyProtocol {

    var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

    func initialSplashScreen() -> UIViewController {
        return Navigation.shared.buildSplashViewModule()
    }

    func initialScreen() -> UIViewController {
        return initialSplashScreen()
    }
}
