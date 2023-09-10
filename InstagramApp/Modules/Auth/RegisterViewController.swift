//
//  RegisterViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let userNameField : UITextField = {
        let field = UITextField()
        field.placeholder = "UserName..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // like a buffer in left side of textfield so the text dont touch the field frame.
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.Corner.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.label.cgColor
        return field
    }()
    
    private let EmailField : UITextField = {
        let field = UITextField()
        field.placeholder = "Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // like a buffer in left side of textfield so the text dont touch the field frame.
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.Corner.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.label.cgColor
        return field
    }()
    
    private let passwordField : UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // like a buffer in left side of textfield so the text dont touch the field frame.
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.Corner.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.label.cgColor
        
        return field
    }()
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer
            .cornerRadius = Constants.Corner.cornerRadius
        button.backgroundColor = .systemGreen
        
        return button
    }()
    
    
    
    
    // MARK: - LifCucle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        assignFramesToUI()
    }
    
    
    // MARK: - Private Functions
    
    private func setUpUI(){
        view.backgroundColor = .systemBackground
        addSubViews()
        configureButton()
        configureTextField()
    }
    
    private func addSubViews(){
        let subViews: [UIView] = [
            userNameField,EmailField,passwordField,registerButton
        ]
        for subView in subViews {
            view.addSubview(subView)
        }
    }
    
    private func assignFramesToUI(){
        //userName
        userNameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 55)
        //email
        EmailField.frame = CGRect(x: 20, y: userNameField.bottom+10, width: view.width-40, height: 55)
        //password
        passwordField.frame = CGRect(x: 20, y: EmailField.bottom+10, width: view.width-40, height: 55)
        //registerBtn
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 55)
    }
    
    private func configureButton(){
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    private func configureTextField(){
        [userNameField,EmailField,passwordField].forEach({
            $0.delegate = self
        })
    }
    // MARK: - @objc func
    
    @objc private func didTapRegister(){
        userNameField.resignFirstResponder()//dissmis keyboard
        EmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let userName = userNameField.text, !userName.isEmpty, let email = EmailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        //register functionality
        AuthManager.shared.registerNewUser(userName: userName, email: email, password: password) { registerd in
            DispatchQueue.main.async {
                if registerd {
                    //good to go
                }else{
                    // failed
                }
            }
           
        }
    }
}

// MARK: - TextField Delegate
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            EmailField.becomeFirstResponder()
        }else if textField == EmailField {
            passwordField.becomeFirstResponder()
        }else {
            didTapRegister()
        }
        return true
    }
}
