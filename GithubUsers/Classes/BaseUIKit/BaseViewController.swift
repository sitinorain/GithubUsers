//
//  BaseViewController.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        commonConfiguration()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func commonConfiguration() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(viewDidTapped(_:))
        )
        singleTapGestureRecognizer.cancelsTouchesInView = false
        singleTapGestureRecognizer.delegate = self
        view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    func configureViews() {
        view.backgroundColor = R.color.backgroundColor()
    }
    
    @objc private func viewDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let isControlTapped = touch.view is UIControl
        return !isControlTapped
    }
}
