//
//  DetailsViewController.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class DetailsViewController: ScrollViewController {
    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var followingLabel: UILabel!
    @IBOutlet private var followerLabel: UILabel!
    @IBOutlet private var dateCreatedLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    var viewModel: DetailsViewModel!
    
    static func fromStoryboard() -> DetailsViewController {
        let viewController = R.storyboard.details.instantiateInitialViewController()!
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        setupObserver()
        viewModel.getUserDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func configureViews() {
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        if #available(iOS 10, *) {
            contentView.refreshControl = refreshControl
        } else {
            contentView.addSubview(refreshControl)
        }
    }
    
    private func setupObserver() {
        viewModel.user
            .asObservable()
            .map { $0.login }
            .bind(to: navigationItem.rx.title)
            .disposed(by:self.disposeBag)
        
        viewModel.user
            .asObservable()
            .map { $0.avatar_url }
            .subscribe(onNext: { [weak self] avatar_url in
                if let urlString = avatar_url, let url = URL(string: urlString) {
                    self?.avatarView.kf.setImage(with: url)
                } else {
                    //should set image placeholder
                    self?.avatarView.image = nil
                }
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        viewModel.user
            .asObservable()
            .map { $0.name ?? "N/A" }
            .bind(to: nameLabel.rx.text)
            .disposed(by:self.disposeBag)
        
        viewModel.user
            .asObservable()
            .map { $0.email ?? "N/A" }
            .bind(to: emailLabel.rx.text)
            .disposed(by:self.disposeBag)
        
        viewModel.user
            .asObservable()
            .map { "\($0.following ?? 0)" }
            .bind(to: followingLabel.rx.text)
            .disposed(by:self.disposeBag)
        
        viewModel.user
            .asObservable()
            .map { "\($0.followers ?? 0)" }
            .bind(to: followerLabel.rx.text)
            .disposed(by:self.disposeBag)
        
        viewModel.user
            .asObservable()
            .map { user -> Binder<String?>.Element in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                guard let dateString = user.created_at, let date = dateFormatter.date(from: dateString) else {
                    return "N/A"
                }
                dateFormatter.dateFormat = "d MMMM yyyy, hh:mm a"
                return dateFormatter.string(from: date)
            }
            .bind(to: dateCreatedLabel.rx.text)
            .disposed(by:self.disposeBag)

        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.getUserDetails()
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .map { _ in self.refreshControl.isRefreshing }
            .filter { $0 == true }
            .subscribe { [weak self] _ in
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
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
