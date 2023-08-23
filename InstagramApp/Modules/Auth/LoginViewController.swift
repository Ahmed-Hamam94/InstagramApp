//
//  LoginViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let userNameEmailField : UITextField = {
        
        return UITextField()
    }()
    
    private let passwordField : UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton : UIButton = {
        return UIButton()
    }()
    
    private let createAccButton : UIButton = {
        return UIButton()
    }()
    
    private let termsButton : UIButton = {
        return UIButton()
    }()
    
    private let privacyButton : UIButton = {
        return UIButton()
    }()
    
    private let headerView : UIView = {
        return UIView()
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor =
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // assign frames
    }

    
    // MARK: - private functions

    private func addSubbViews(){
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginBtn(){}
    @objc private func didTapTermsBtn(){}
    @objc private func didTapPrivacyBtn(){}
    @objc private func didTapCreatAccBtn(){}

}
