//
//  FeedPostHeaderTableViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 27/08/2023.
//

import UIKit
import SDWebImage


protocol FeedPostHeaderTableViewCellDelegate: AnyObject {
   // func didTapMoreButton(_ model: User)
    func didTapMoreButton()
}

class FeedPostHeaderTableViewCell: UITableViewCell {

    static let identifieer = "FeedPostHeaderTableViewCell"
    
    weak var delegate: FeedPostHeaderTableViewCellDelegate?
   //MARK: - UI
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
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
        usernameLabel.text = nil
        profileImageView.image = nil
    }
    
    
    private func addSubViews(){
        let subViews = [profileImageView, usernameLabel, moreButton]
        for subView in subViews {
            contentView.addSubview(subView)
        }
        
    }
    
    private func assignFrames(){
        let size = contentView.height-4
        
        profileImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profileImageView.layer.cornerRadius = size/2
        moreButton.frame = CGRect(x: contentView.width-size, y: 2, width: size, height: size)
        usernameLabel.frame = CGRect(x: profileImageView.right+10,
                                     y: 2, width: contentView.width-(size*2)-15, height: contentView.height-4)
    }
    
    @objc private func didTapMoreButton(){
        delegate?.didTapMoreButton()
    }
    
    // configure cell
    public func configure(with model: User){
        usernameLabel.text = model.username
        profileImageView.image = UIImage(systemName: "person.circle")
        //profileImageView.sd_setImage(with: model.profileImage)
    }

}
