//
//  FeedPostGeneralTableViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 27/08/2023.
//

import UIKit

/// comments
class FeedPostGeneralTableViewCell: UITableViewCell {

    static let identifieer = "FeedPostGeneralTableViewCell"
   
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // configure cell
    public func configure(){
        
    }

}
