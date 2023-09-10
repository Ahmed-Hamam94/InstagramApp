//
//  PhotoCollectionViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 28/08/2023.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true //to nothing overflows
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func configure(with model: UserPost){
         let thumbnailUrl = model.thumbnailImage //download asset from url and assign it to imgview
         photoImageView.sd_setImage(with: thumbnailUrl)
         
         
    }
    
    func configure(imageName: String){ // for test
        photoImageView.image = UIImage(named: imageName)
    }
}
