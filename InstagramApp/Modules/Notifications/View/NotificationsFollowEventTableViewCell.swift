//
//  NotificationsFollowEventTableViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 30/08/2023.
//

import UIKit

protocol NotificationsFollowEventDelegate: AnyObject{
    
    func didTapFollowUnfollowButton(model: UserNottification)
}

class NotificationsFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationsFollowEventTableViewCell"
    
    weak var delegate: NotificationsFollowEventDelegate?
    private var model: UserNottification?
    //MARK: - UI
    
    private let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .tertiarySystemBackground
        
        return imageview
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@mask followed you"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        selectionStyle = .none
        addSubViews()
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureFollowState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        assignFrames()
    }
    //MARK: - Private Functions
    
    private func addSubViews(){
        let subViews = [profileImageView, label, followButton]
        for subView in subViews {
            contentView.addSubview(subView)
        }
        
    }
    
    private func assignFrames(){
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(x: contentView.width-5-size,
                                    y: (contentView.height-buttonHeight)/2,
                                    width: size,
                                    height: buttonHeight)
       
        
        label.frame = CGRect(x: profileImageView.right+5, y: 0, width: contentView.width-size-profileImageView.width-16, height: contentView.height)
    }
    
    @objc private func didTapFollowButton(){
        guard let model else {return}
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    private func configureFollowState(){
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    //MARK: - Functions
    
    func configure(with model: UserNottification){
        self.model = model
        
        switch model.type {
            
        case .like(_):
            
            break
        case .follow(let state):
            //configure button
            switch state {
            case .following:
                //show follow button
               configureFollowState()
                
            case .not_following:
                //show unfollow button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
            }
            
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profileImage)
    }
}
