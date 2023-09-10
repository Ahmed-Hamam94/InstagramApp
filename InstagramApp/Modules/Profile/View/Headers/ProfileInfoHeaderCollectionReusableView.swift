//
//  PhotoInfoHeaderCollectionReusableView.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 28/08/2023.
//

import UIKit

protocol ProfileInfoHeaderDelegate: AnyObject{
    func profileHeaderDidTabPostsBtn(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTabFollowerBtn(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTabFollowingBtn(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTabEditBtn(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "PhotoInfoHeaderCollectionReusableView"
    weak var delegate: ProfileInfoHeaderDelegate?
    //MARK: - UI
    private let profileImageview: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .cyan
        imageView.clipsToBounds = true
        return imageView
    }()
    private let postsButton: UIButton = {
       let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let followersButton: UIButton = {
       let button = UIButton()
        button.setTitle("Followes", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let followingButton: UIButton = {
       let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let editProfileButton: UIButton = {
       let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Ahmed H"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let bioLabel: UILabel = {
       let label = UILabel()
        label.text = "This is first account for me ........"
        label.textColor = .label
        label.numberOfLines = 0 //line wrap
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubViews()
        addButtonsAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        assignFrames()
    }
    
    //MARK: - Private Func
    private func addSubViews(){


        let outlets = [postsButton,followersButton,followingButton,editProfileButton,nameLabel,bioLabel,profileImageview]

        for outlet in outlets {
            addSubview(outlet)
        }
        
      
    }
    
    private func assignFrames(){
        let profileImageSize = width/4
        profileImageview.layer.cornerRadius = profileImageSize/2

        
        profileImageview.frame = CGRect(x: 5, y: 5, width: profileImageSize, height: profileImageSize).integral
        
        let buttonHeight = profileImageSize/2
        let countButtonWidth = (width-10-profileImageSize)/3
        
        postsButton.frame = CGRect(x: profileImageview.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        
        followersButton.frame = CGRect(x: postsButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(x: profileImageview.right, y: 5+buttonHeight, width: countButtonWidth*3, height: buttonHeight).integral
        
        nameLabel.frame = CGRect(x: 5, y: 5+profileImageview.bottom, width: width-10, height: 50).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)//return size based on text
        
        bioLabel.frame = CGRect(x: 5, y: 5+nameLabel.bottom, width: width-10, height: bioLabelSize.height).integral
    }
    private func addButtonsAction(){
        
        postsButton.addTarget(self, action: #selector(didTabPost), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTabFollowers), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTabFollowing), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTabEdit), for: .touchUpInside)
    }
    //MARK: - objc func
    @objc private func didTabPost(){
        delegate?.profileHeaderDidTabPostsBtn(self)
    }
    
    @objc private func didTabFollowers(){
        delegate?.profileHeaderDidTabFollowerBtn(self)
    }
    
    @objc private func didTabFollowing(){
        delegate?.profileHeaderDidTabFollowingBtn(self)
    }
    
    @objc private func didTabEdit(){
        delegate?.profileHeaderDidTabEditBtn(self)
    }
}
