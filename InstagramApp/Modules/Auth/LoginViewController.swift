//
//  LoginViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit
import SafariServices
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let userNameEmailField : UITextField = {
        let field = UITextField()
        field.placeholder = "UserName Or Email..."
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
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer
            .cornerRadius = Constants.Corner.cornerRadius
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    private let createAccButton : UIButton = {
        let button =  UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private let termsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Serviced", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let headerView : UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backGroundImage = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backGroundImage)
        
        return header
    }()
    
   
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubbViews()
        configureButtons()
        configureTextField()
        // Handle successful login
        
    }
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // assign frames
        
        assignFramesToUI()
        configureHeaderView()
        
    }
    
    
    // MARK: - private functions
    
    private func addSubbViews(){
        let subviews: [UIView] = [
            userNameEmailField,
            passwordField,
            loginButton,
            termsButton,
            privacyButton,
            createAccButton,
            headerView
        ]
        
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func assignFramesToUI(){
        //headerView
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.height/3.0)
        //userNameEmail
        userNameEmailField.frame = CGRect(x: 25,
                                          y: headerView.bottom + 50,
                                          width: view.width - 50,
                                          height: 52.0)
        //password
        passwordField.frame = CGRect(x: 25, y: userNameEmailField.bottom + 10, width: view.width - 50, height: 52.0)
        //login
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 52.0)
        // createAcc
        createAccButton.frame = CGRect(x: 25,
                                       y: loginButton.bottom + 10,
                                       width: view.width - 50,
                                       height: 52.0)
        //terms
        termsButton.frame = CGRect(x: 10,
                                   y: view.height-view.safeAreaInsets.bottom-100, width: view.width-20, height: 50)
        //privacy
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height-view.safeAreaInsets.bottom-50, width: view.width-20, height: 50)
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else{
            return
        }
        guard let backGround = headerView.subviews.first  else {
            return
        }
        backGround.frame = headerView.bounds
        // Add instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4, y: view.safeAreaInsets.top, width: headerView.width/2, height: headerView.height - view.safeAreaInsets.top)
        
    }
    
    private func configureTextField(){
        [userNameEmailField,passwordField].forEach({
            $0.delegate = self
        })
    }
    private func configureButtons(){
        loginButton.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
        createAccButton.addTarget(self, action: #selector(didTapCreatAccBtn), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsBtn), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyBtn), for: .touchUpInside)
    }
    // MARK: - @objc func
    
    @objc private func didTapLoginBtn(){
        passwordField.resignFirstResponder() //dissmis keyboard
        userNameEmailField.resignFirstResponder()
        guard let userNameEmail = userNameEmailField.text , !userNameEmail.isEmpty, let password = passwordField.text , !password.isEmpty , password.count >= 8 else {
            return
        }
        // login functionality
        // i need to know if userName or email used
        var email: String?
        var userName: String?
        
        if userNameEmail.contains("@"), userNameEmail.contains(".") {
            //email
            email = userNameEmail
        }else {
            //userName
            userName = userNameEmail
        }
        AuthManager.shared.login(userName: userName,email: email,password: password) {  [weak self] (success) in
            
            DispatchQueue.main.async {
                if success {
                    // log in
                    self?.dismiss(animated: true)
                }else{
                    //error occurred
                    self?.alert(title: "Log In Error", message: "We were unable to Log in")
                }
            }
           
        }
    }
    
    @objc private func didTapTermsBtn(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870/?helpref=uf_share") else { return }
        let vc = SFSafariViewController(url: url
        )
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyBtn(){
        guard let url = URL(string: "https://privacycenter.instagram.com/policy") else { return }
        let vc = SFSafariViewController(url: url
        )
        present(vc, animated: true)
    }
    @objc private func didTapCreatAccBtn(){
        let vc = RegisterViewController()
        vc.title = "Creat Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
// MARK: - TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            didTapLoginBtn()
        }
        return true
    }
    
}
