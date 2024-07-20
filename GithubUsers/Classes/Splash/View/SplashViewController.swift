//
//  SplashViewController.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit

class SplashViewController: BaseViewController {
    
    var viewModel: SplashViewModel!
    
    static func fromStoryboard() -> SplashViewController {
        let viewController = R.storyboard.splash.instantiateInitialViewController()!
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(proceedToNextScreen), with: nil, afterDelay: 1.0)
    }
    
    override func configureViews() {
        view.backgroundColor = R.color.themeColor()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc private func proceedToNextScreen() {
        viewModel.navigateToListingView(from: self)
    }
}
