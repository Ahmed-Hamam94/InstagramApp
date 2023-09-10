//
//  NoNotificationsView.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 30/08/2023.
//

import UIKit

class NoNotificationsView: UIView {

    private let label: UILabel = {
       let label = UILabel()
        label.text = "No Notifications Yet"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageview = UIImageView()
        imageview.tintColor = .secondaryLabel
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(systemName: "bell")
        return imageview
    }()
    

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
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
        addSubview(label)
        addSubview(imageView)
    }
    private func assignFrames(){
        imageView.frame = CGRect(x: (width-50)/2,
                             y: 0,
                             width: 50,
                                 height: 50).integral
        label.frame = CGRect(x: 0,
                             y: imageView.bottom,
                             width: width,
                             height: height-50).integral
    }
}

