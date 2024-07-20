//
//  ListingViewController.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ListingViewController: TableViewController {
    
    private let disposeBag = DisposeBag()
    private let cell = ListingTableViewCell.fromXib()
    private let refreshControl = UIRefreshControl()
    
    var viewModel: ListingViewModel!
    
    static func fromStoryboard() -> ListingViewController {
        let viewController = R.storyboard.listing.instantiateInitialViewController()!
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupObserver()
        viewModel.getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func configureViews() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Github Users"
        
        tableView.register(cell.cellNib, forCellReuseIdentifier: cell.reuseIdentifier)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        if #available(iOS 10, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    private func setupObserver() {
        viewModel.users
            .bind(to: tableView
                    .rx
                    .items(cellIdentifier: cell.reuseIdentifier,
                           cellType: ListingTableViewCell.self)) { row, user, cell in
                cell.refreshViews(name: user.login, url: user.url, avatar: user.avatar_url)
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(User.self)
            .subscribe(onNext: { [weak self] user in
                if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
                    self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
                self?.didSelectedUser(user)
            })
            .disposed(by: disposeBag)
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.getUsers()
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
    
    private func didSelectedUser(_ user: User) {
        viewModel.navigateToDetailsView(from: self, withSelectedUser: user)
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
