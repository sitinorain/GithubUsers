//
//  ListingTableViewCell.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import UIKit
import Kingfisher

class ListingTableViewCell: UITableViewCell {
    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var urlLabel: UILabel!
    
    static func fromXib() -> (cellNib: UINib, reuseIdentifier: String) {
        return (UINib(resource: R.nib.listingTableViewCell), String(describing: self))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureViews() {
        
    }
    
    func refreshViews(name: String? = nil, url: String? = nil, avatar: String? = nil) {
        nameLabel.text = name
        urlLabel.text = url
        if let urlString = avatar, let url = URL(string: urlString) {
            avatarView.kf.setImage(with: url)
        } else {
            //should set image placeholder
            avatarView.image = nil
        }
    }
}
