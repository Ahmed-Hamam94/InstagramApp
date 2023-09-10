//
//  NotificationLikeEventTableViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 30/08/2023.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventDelegate: AnyObject{
    
    func didTapRelatedButton(model: UserNottification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventDelegate?
    
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
        label.text = "@mo liked your post"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        selectionStyle = .none
        addSubViews()
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        assignFrames()
    }
    //MARK: - Private Functions
    
    private func addSubViews(){
        let subViews = [profileImageView, label, postButton]
        for subView in subViews {
            contentView.addSubview(subView)
        }
        
    }
    private func assignFrames(){
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
       let size = contentView.height-4
        postButton.frame = CGRect(x: contentView.width-5-size, y: 2, width: size, height: size)
        
        label.frame = CGRect(x: profileImageView.right+5, y: 0, width: contentView.width-size-profileImageView.width-16, height: contentView.height)
    }
    
    @objc private func didTapPostButton(){
        guard let model else {return}
        delegate?.didTapRelatedButton(model: model)
    }
    
    
    //MARK: - Functions
    func configure(with model: UserNottification){
        self.model = model
        
        switch model.type {
            
        case .like(let post):
           
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else{return}
            
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal)
        case .follow:
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profileImage)
    }
    
}
