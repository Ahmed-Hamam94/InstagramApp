//
//  EditProfileFormTableViewCell.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 27/08/2023.
//

import UIKit

protocol EditProfileFormDelegate: AnyObject {
    func formTableViewCell(_ cell: EditProfileFormTableViewCell, didUpdateField updatedModel: EditProfileForm?)
}

class EditProfileFormTableViewCell: UITableViewCell {

    static let identifier = "EditProfileFormTableViewCell"
    weak var delegate: EditProfileFormDelegate?
    private var model: EditProfileForm?
    
    private let formLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(formLabel)
        contentView.addSubview(textField)
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //assign frames
        formLabel.frame = CGRect(x: 10, y: 0, width: contentView.width/3, height: contentView.height)
        textField.frame = CGRect(x: formLabel.right+5, y: 0, width: contentView.width-10-formLabel.width, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
    
    func configure(with model: EditProfileForm){
        self.model = model
        formLabel.text = model.label
        textField.placeholder = model.placeHolder
        textField.text = model.value
    }
}

extension EditProfileFormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model else {return true}
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
