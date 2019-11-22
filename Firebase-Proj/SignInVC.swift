//
//  ViewController.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/22/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    let userFieldImage = UIImageView()
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.text = "Pursuitstgram"
        label.font = UIFont(name: "Arial", size: 45.0)
        return label
    }()
    
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightText
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightText
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-Bold", size: 16)
        button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        button.layer.cornerRadius = 5
        //button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
      lazy var createAccountButton: UIButton = {
          let button = UIButton(type: .system)
          let attributedTitle = NSMutableAttributedString(string: "Dont have an account?  ",
                                                          attributes: [
                                                              NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!,
                                                              NSAttributedString.Key.foregroundColor: UIColor.white])
          attributedTitle.append(NSAttributedString(string: "Sign Up",
                                                    attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!,
                                                                 NSAttributedString.Key.foregroundColor:  UIColor.blue]))
          button.setAttributedTitle(attributedTitle, for: .normal)
          //button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
          return button
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(loginButton)
        self.view.addSubview(createAccountButton)
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setEmailFieldConstraints()
        setPasswordFieldConstraints()
        setLogInButtonConstraints()
        setCreateAccountButtonConstraints()
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setEmailFieldConstraints() {
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailField.widthAnchor.constraint(equalToConstant: 300),
            emailField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setPasswordFieldConstraints() {
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 300),
            passwordField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setLogInButtonConstraints() {
          loginButton.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
              loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
              loginButton.widthAnchor.constraint(equalToConstant: 300),
              loginButton.heightAnchor.constraint(equalToConstant: 50)
          ])
      }
    
    private func setCreateAccountButtonConstraints() {
             createAccountButton.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                 createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
                 createAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                 createAccountButton.widthAnchor.constraint(equalToConstant: 300),
                 createAccountButton.heightAnchor.constraint(equalToConstant: 50)
             ])
         }
}

