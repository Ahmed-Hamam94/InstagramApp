//
//  ProfileTabsCollectionReusableView.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 28/08/2023.
//

import UIKit

protocol ProfileTabsDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()

}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileTabsCollectionReusableView"
    weak var delegate: ProfileTabsDelegate?
    private var padding: CGFloat = 8
    
    //MARK: - UI
    let gridButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    let taggedButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
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
    //MARK: - Private Functions
    private func addSubViews(){
        addSubview(gridButton)
        addSubview(taggedButton)
    }
    private func assignFrames(){
        let size = height - (padding*2)
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: padding,
                                  width: size,
                                  height: size)
        taggedButton.frame = CGRect(x: gridButtonX + width/2,
                                  y: padding,
                                  width: size,
                                  height: size)
    }
    private func addButtonsAction(){
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    //MARK: - @objc func
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTaggedButton(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedButtonTab()
    }
}
