//
//  UserFollowTableViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 30/08/2023.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject{
    func didTapFollowUnfollowButton(model: UserRelationship)
}

class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    weak var delegate: UserFollowTableViewCellDelegate?
    private var model: UserRelationship?
    
    //MARK: - UI
    let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .secondarySystemBackground
        return imageview
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "ahmed"
        return label
    }()
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "@ahmed"
        return label
    }()
    let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubbViews()
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        assignFrames()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    //MARK: - Private Func
    
    private func addSubbViews(){
        let subViews = [profileImageView, nameLabel, usernameLabel, followButton]
        for subView in subViews {
            contentView.addSubview(subView)
        }
    }
    private func assignFrames(){
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        let buttonWidth = contentView.width > 500 ? 220 : contentView.width/3
        
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth,
                                    y: (contentView.height-40)/2,
                                    width: buttonWidth,
                                    height: 40)
        
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: profileImageView.right+5,
                                 y: 0,
                                 width: contentView.width-8-profileImageView.width-buttonWidth,
                                 height: labelHeight)
        
        usernameLabel.frame = CGRect(x: profileImageView.right+5,
                                     y: nameLabel.bottom,
                                     width: contentView.width-8-profileImageView.width-buttonWidth,
                                     height: labelHeight)
        
        
    }
    //MARK: - public Func
    public func configure(with model: UserRelationship){
        
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        
        switch model.type {
        case .following:
            //show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
            
        case .not_following:
            //show following button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
           
        }
    }
    //MARK: - Objc fun
    @objc private func didTapFollow(){
        guard let model else {return}
        delegate?.didTapFollowUnfollowButton(model: model)
    }
}
