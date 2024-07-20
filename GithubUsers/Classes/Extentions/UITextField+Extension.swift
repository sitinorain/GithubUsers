//
//  UITextField+Extension.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit
import RxSwift
import RxCocoa

extension UITextField {
    func resignWhenFinished(_ disposeBag: DisposeBag) {
        setNextResponder(nil, disposeBag: disposeBag)
    }

    func setNextResponder(_ nextResponder: UIResponder?, disposeBag: DisposeBag) {
        // Set the return key type to:
        //   - next: When there is a next responder
        //   - done: When there is no next responder (simply resign)
        returnKeyType = (nextResponder != nil) ? .next : .done

        // Subscribe on editing end on exit control event
        rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self, weak nextResponder] in
                if let nextResponder = nextResponder {
                  // Switch to next responder if available
                  nextResponder.becomeFirstResponder()
                } else {
                  // Otherwise simply resign
                  self?.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
    }
}
