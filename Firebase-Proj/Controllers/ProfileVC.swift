//
//  ProfileVC.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/23/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class ProfileVC: UIViewController {
    
    var displayNameHolder = "Display Name"
    
    var defaultImage = UIImage(systemName: "person")
    
    var savedImage : UIImage! {
        didSet {
            imageView.image = savedImage
        }
    }
    
    var imageURL: URL? = nil
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Profile"
        label.font = UIFont(name: "Arial", size: 45.0)
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.image = defaultImage
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AddButton"), for: .normal)
        button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
        return button
    }()
    
    lazy var userNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = displayNameHolder
        label.font = UIFont(name: "Arial", size: 25.0)
        label.textAlignment = .center
        return label
    }()
    
    lazy var editDisplayNameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Username", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(editDisplayNamePressed), for: .touchUpInside)
        return button
    }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setSubviews()
        setConstraints()
        if let displayName = FirebaseAuthService.manager.currentUser?.displayName {
            loadImage()
            userNameLabel.text = displayName
            
            let user = FirebaseAuthService.manager.currentUser
            imageURL = user?.photoURL
        }
        
    }
    //MARK: Obj-C Methods
    
    @objc func signOutButtonPressed() {
        FirebaseAuthService.manager.signOutUser()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window else {return}
        
        window.rootViewController = SignInVC()
    }
    
    @objc func addImagePressed() {
        checkAuthorizationForAccessingPhotos()
    }
    
    @objc func editDisplayNamePressed() {
        let alert = UIAlertController(title: "UserName", message: nil, preferredStyle: .alert)
        
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter UserName"
        }
        
        guard let userNameField = alert.textFields else {return}
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (alert) -> Void in
            
            self.userNameLabel.text = userNameField[0].text ?? self.displayNameHolder
            self.formValidation()
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func saveButtonPressed() {
        guard let userName = userNameLabel.text, let image = imageView.image else {
            print("Defaults are not working")
            return
        }
        
        let validInput = (userName != displayNameHolder) && (image != defaultImage)
        
        if validInput {
            
            guard let imageUrl = imageURL else {
                print("Not able to compute imageUrl")
                return
            }
            
            FirebaseAuthService.manager.updateUserFields(userName: userName, photoURL: imageUrl) { (result) in
                switch result {
                case .success():
                    FirestoreService.manager.updateCurrentUser(userName: userName, photoURL: imageUrl) { [weak self] (nextResult) in
                        switch nextResult {
                        case .success():
                            
                            self?.transitionToMainFeed()
                        case .failure(let error):
                            print("Failure to update current user: \(error)")
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            showErrorAlert(title: "Missing Requirements", message: "Profile needs a username and image")
        }
        
        
    }
    
    //MARK: Private func
    
    
    private func loadImage() {
        guard let imageUrl = FirebaseAuthService.manager.currentUser?.photoURL else {
            print("photo url not found")
            return
        }
        ImageHelper.shared.getImage(urlStr: imageUrl.absoluteString) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let imageFromUrl):
                DispatchQueue.main.async {
                    self.savedImage = imageFromUrl
                }
                
            }
        }
    }
    
    private func setupCaptureSession() {
        DispatchQueue.main.async {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.allowsEditing = true
            myPickerController.mediaTypes = ["public.image"]
            self.present(myPickerController, animated: true, completion: nil)
            
        }
    }
    
    private func checkAuthorizationForAccessingPhotos() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            return setupCaptureSession()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupCaptureSession()
                }
            }
            
        case .denied: // The user has previously denied access.
            return alertCameraAccessNeeded()
            
        case .restricted: // The user can't grant access due to restrictions.
            return
            
        default:
            return
        }
    }
    
    private func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to make full use of this app.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func formValidation() {
        let validUserName = userNameLabel.text != displayNameHolder
        let imagePresent = imageView.image != defaultImage
        saveButton.isEnabled = validUserName && imagePresent
    }
    
    private func transitionToMainFeed() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window else {return}
        
        window.rootViewController = TabBarVC()
        
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    //MARK: UI Setup
    
    private func setSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(imageView)
        self.view.addSubview(addImageButton)
        self.view.addSubview(userNameLabel)
        self.view.addSubview(editDisplayNameButton)
        self.view.addSubview(saveButton)
        self.view.addSubview(signOutButton)
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setImageViewConstraints()
        setAddImageButtonConstraints()
        setDisplayLabelConstraints()
        setEditDisplayButtonConstraints()
        setSaveButtonConstraints()
        setSignoutButtonConstraints()
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    private func setSaveButtonConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35),
            saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            addImageButton.widthAnchor.constraint(equalToConstant: 50),
            addImageButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func setSignoutButtonConstraints() {
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35),
            signOutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            signOutButton.widthAnchor.constraint(equalToConstant: 100),
            signOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setAddImageButtonConstraints() {
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addImageButton.topAnchor.constraint(equalTo: self.imageView.topAnchor),
            addImageButton.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            addImageButton.widthAnchor.constraint(equalToConstant: 50),
            addImageButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func setDisplayLabelConstraints() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            userNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            userNameLabel.widthAnchor.constraint(equalToConstant: 200),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    
    private func setEditDisplayButtonConstraints() {
        editDisplayNameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editDisplayNameButton.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 10),
            editDisplayNameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            editDisplayNameButton.widthAnchor.constraint(equalToConstant: 200),
            editDisplayNameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("Could not get image")
            return
        }
        savedImage = image
        formValidation()
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        FirebaseStorageService.manager.storeImage(image: imageData) { [weak self] (result) in
            switch result {
            case .success(let url):
                self?.imageURL = url
            case .failure(let error):
                print(error)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
