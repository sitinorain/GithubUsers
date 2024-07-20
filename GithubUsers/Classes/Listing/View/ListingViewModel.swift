//
//  ListingViewModel.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ListingViewModel: NSObject {
    private let userService: UserService
    private let disposeBag = DisposeBag()
    let users: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    
    init(userService: UserService) {
        self.userService = userService
        super.init()
    }
    
    func getUsers() {
        userService.getUserList { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                self.users.accept(value)
            case .failure(let error):
                print("userService.getUserList, error: \(error)")
                //TO DO - specific error handling
            }
        }
    }
    
    func navigateToDetailsView(from: UIViewController, withSelectedUser user: User) {
        guard let fromViewController = from as? ListingViewController else { return }
        ListingConfigurator.shared.delegate?.navigateToDetailsViewFromListing(fromViewController, withSelectedUser: user)
    }
}
