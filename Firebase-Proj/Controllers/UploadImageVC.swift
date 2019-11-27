//
//  UploadImageVC.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/24/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit
import AVFoundation

class UploadImageVC: UIViewController {
    
    var savedImage : UIImage! {
        didSet {
            imageView.image = savedImage
        }
    }
    
    var imageURL: URL? = nil
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Upload Image"
        label.font = UIFont(name: "Arial", size: 45.0)
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        return imageView
    }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AddButton"), for: .normal)
        button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
        return button
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(uploadButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setSubviews()
        setConstraints()
    }
    
    //MARK: Obj-C Methods
    
    @objc func addImagePressed() {
        checkAuthorizationForAccessingPhotos()
    }
    
    @objc func uploadButtonPressed() {
        
        guard let currentUser = FirebaseAuthService.manager.currentUser else {
            showErrorAlert(title: "Error", message: "You must log-in to post")
            return
        }
        
        
        
        guard let userName = currentUser.displayName else {
            showErrorAlert(title: "Missing Username", message: "You must finish your profile before posting")
            return
        }
        
        guard let url = imageURL else {
            showErrorAlert(title: "Error", message: "Could not find image")
            return
        }
        
        let newPost = Post(imageUrl: url.absoluteString, userName: userName, creatorID: currentUser.uid, dateCreated: Date())
        
        FirestoreService.manager.createPost(post: newPost) { (result) in
            self.handlePostResponse(withResult: result)
        }
        
        
    }
    
    //MARK: Private func
    
    private func handlePostResponse(withResult result: Result<Void, Error>) {
        switch result {
        case .success:
            let alertVC = UIAlertController(title: "Post Uploaded", message: "New post was added", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            present(alertVC, animated: true, completion: nil)
        case let .failure(error):
            print("An error occurred creating the post: \(error)")
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
        let imagePresent = imageView.image != UIImage(named: "noImage")
        uploadButton.isEnabled = imagePresent
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
        self.view.addSubview(uploadButton)
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setImageViewConstraints()
        setAddImageButtonConstraints()
        setUploadButtonConstraints()
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
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
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 350)
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
    
    private func setUploadButtonConstraints() {
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 50),
            uploadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            uploadButton.widthAnchor.constraint(equalToConstant: 200),
            uploadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension UploadImageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("Could not get image")
            return
        }
        savedImage = image
        formValidation()
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {return}
        
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

