//
//  DetailsViewModel.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailsViewModel: NSObject {
    private let userService: UserService
    private let disposeBag = DisposeBag()
    let user: BehaviorRelay<User>
    
    init(user: User, userService: UserService) {
        self.user = BehaviorRelay(value: user)
        self.userService = userService
        super.init()
    }
    
    func getUserDetails() {
        guard let userId = user.value.id else {
            //TO DO - specific error handling
            return
        }
        
        userService.getUserDetails(userId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                self.user.accept(value)
            case .failure(let error):
                print("userService.getUserDetails, error: \(error)")
                //TO DO - specific error handling
            }
        }
    }
}
