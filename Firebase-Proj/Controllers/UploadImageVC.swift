//
//  UploadImageVC.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/24/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class UploadImageVC: UIViewController {
    
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
            //button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
            return button
        }()

    lazy var uploadButton: UIButton = {
               let button = UIButton()
           button.setTitle("Upload", for: .normal)
           button.setTitleColor(.blue, for: .normal)
               //button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
               return button
           }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setSubviews()
        setConstraints()
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
