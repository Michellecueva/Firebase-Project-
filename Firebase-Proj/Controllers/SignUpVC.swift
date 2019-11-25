//
//  SignUpVC.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/22/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpVC: UIViewController {

    lazy var titleLabel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 0
           label.text = "Pursuitstgram: Create Account"
           label.font = UIFont(name: "Arial", size: 28)
            label.textColor = .white
           label.backgroundColor = .clear
           label.textAlignment = .center
           return label
       }()
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.font = UIFont(name: "Verdana", size: 14)
        textField.backgroundColor = .white
        textField.borderStyle = .bezel
        textField.autocorrectionType = .no
        //textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
       
    lazy var lastNameTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Last Name"
           textField.font = UIFont(name: "Verdana", size: 14)
           textField.backgroundColor = .white
           textField.borderStyle = .bezel
           textField.autocorrectionType = .no
         //  textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
           return textField
       }()
    
       lazy var emailTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Enter Email"
           textField.font = UIFont(name: "Verdana", size: 14)
           textField.backgroundColor = .white
           textField.borderStyle = .bezel
           textField.autocorrectionType = .no
         //  textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
           return textField
       }()
       
       lazy var passwordTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Enter Password"
           textField.font = UIFont(name: "Verdana", size: 14)
           textField.backgroundColor = .white
           textField.borderStyle = .bezel
           textField.autocorrectionType = .no
           textField.isSecureTextEntry = true
          // textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
           return textField
       }()
       
       lazy var createButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Create", for: .normal)
           button.setTitleColor(.white, for: .normal)
           button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
        button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
           button.layer.cornerRadius = 5
           button.addTarget(self, action: #selector(trySignUp), for: .touchUpInside)
           button.isEnabled = true
           return button
       }()
       
       //MARK: Lifecycle methods
       
       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
           setTitleLabelConstraints()
           setupCreateStackView()
       }
       
       //MARK: Obj-C Methods
       
    
    @objc func trySignUp() {
        
        if validateFields() {
            
            let email = emailTextField.text!
            let password = passwordTextField.text!
            FirebaseAuthService.manager.createNewUser(email: email, password:password) { [weak self] (result) in
                self?.handleCreateAccountResponse(result: result)
            }

        } else {
            return
        }
    }
       

       
       //MARK: Private methods
       
       private func showErrorAlert(title: String, message: String) {
           let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           present(alertVC, animated: true, completion: nil)
       }
    
    private func validateFields() -> Bool {
        guard let _ = firstNameTextField.text, let _ = lastNameTextField.text,let email = emailTextField.text, let password = passwordTextField.text else {
                  showErrorAlert(title: "Error", message: "Please fill out all fields.")
                  return false
              }
              
              guard email.isValidEmail else {
                  showErrorAlert(title: "Error", message: "Please enter a valid email")
                  return false
              }
              
              guard password.isValidPassword else {
                  showErrorAlert(title: "Error", message: "Please enter a valid password. Passwords must have at least 8 characters.")
                  return false
              }
        
        return true
    }
    
    private func handleCreateAccountResponse(result: Result<User, Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let user):
                FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] (result) in
                    switch result {
                    case .success:
                        self?.transitionToProfile()
                    case .failure(let error):
                        self?.showErrorAlert(title: "Error creating user", message: error.localizedDescription)
                    }
                }
            case .failure(let error):
                self?.showErrorAlert(title: "Error creating user", message: error.localizedDescription)
            }
        }
    }
    
    private func transitionToProfile() {
        let profileVC = ProfileVC()
        self.present(profileVC, animated: true, completion: nil)
    }
       
       
       //MARK: UI Setup
       
       private func setTitleLabelConstraints() {
           view.addSubview(titleLabel)
           
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
               titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
               titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
               titleLabel.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)])
       }
       
       private func setupCreateStackView() {
           let stackView = UIStackView(arrangedSubviews: [firstNameTextField,lastNameTextField,emailTextField,passwordTextField,createButton])
           stackView.axis = .vertical
           stackView.spacing = 15
           stackView.distribution = .fillEqually
           self.view.addSubview(stackView)
           
           stackView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
               stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)])
       }
}
