//
//  FeedPostTableViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 27/08/2023.
//

import UIKit
import SDWebImage
import AVFoundation
/// cell for primary post content
final class FeedPostTableViewCell: UITableViewCell {

    static let identifieer = "FeedPostTableViewCell"
   
    private let postImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.layer.addSublayer(playerLayer) // add the layer first
        contentView.addSubview(postImageView)
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    // configure cell
    public func configure(with post: UserPost){
        
        postImageView.image = UIImage(named: "test")
        
        return
        switch post.postType {
            
        case .photo:
            postImageView.sd_setImage(with: post.postUrl)
        case .video:
            player = AVPlayer(url: post.postUrl)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
}
