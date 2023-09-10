//
//  FeedPostActionsTableViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 27/08/2023.
//

import UIKit

protocol FeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class FeedPostActionsTableViewCell: UITableViewCell {

    static let identifieer = "FeedPostActionsTableViewCell"
   
    weak var delegate: FeedPostActionsTableViewCellDelegate?
    //MARK: - UI
    private let likeButton: UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    private let commentButton: UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    private let sendButton: UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubViews()
        addTargetButtons()
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
        
    }
    
    private func addSubViews(){
        let subViews = [likeButton, commentButton, sendButton]
        for subView in subViews {
            contentView.addSubview(subView)
        }
    }
    
    private func assignFrames(){
        let buttonSize = contentView.height-10
        let buttons = [likeButton, commentButton, sendButton]
        
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(x: (CGFloat(x)*buttonSize) + (10*CGFloat(x+1)),
                                  y: 5,
                                  width: buttonSize,
                                  height: buttonSize)
        }
        
    }
    private func addTargetButtons(){
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    @objc private func didTapLikeButton(){
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton(){
        delegate?.didTapCommentButton()
    }
    
    @objc private func didTapSendButton(){
        delegate?.didTapSendButton()
    }
    
    // configure cell
    public func configure(with post: UserPost){
        
    }

}
