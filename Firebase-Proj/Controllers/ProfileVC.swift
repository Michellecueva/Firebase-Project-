//
//  ProfileVC.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/23/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
   
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
          imageView.image = UIImage(systemName: "person")
        imageView.layer.cornerRadius = 30
          return imageView
      }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
    button.setTitle("Save", for: .normal)
    button.setTitleColor(.blue, for: .normal)
        //button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
        return button
    }()
    
    lazy var addImageButton: UIButton = {
         let button = UIButton()
        button.setImage(UIImage(named: "AddButton"), for: .normal)
         //button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
         return button
     }()
    
    lazy var displayLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Display Name"
        label.font = UIFont(name: "Arial", size: 25.0)
        label.textAlignment = .center
        return label
    }()
    
    lazy var editDisplayNameButton: UIButton = {
            let button = UIButton()
        button.setTitle("Edit Username", for: .normal)
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
         self.view.addSubview(displayLabel)
         self.view.addSubview(editDisplayNameButton)
        self.view.addSubview(saveButton)
     }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setImageViewConstraints()
        setAddImageButtonConstraints()
        setDisplayLabelConstraints()
        setEditDisplayButtonConstraints()
        setSaveButtonConstraints()
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
            saveButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                          addImageButton.widthAnchor.constraint(equalToConstant: 50),
                          addImageButton.heightAnchor.constraint(equalToConstant: 50)
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
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                     displayLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
                        displayLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                        displayLabel.widthAnchor.constraint(equalToConstant: 200),
                        displayLabel.heightAnchor.constraint(equalToConstant: 50)
                    ])
        
        
    }
    
    private func setEditDisplayButtonConstraints() {
        editDisplayNameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                           editDisplayNameButton.topAnchor.constraint(equalTo: self.displayLabel.bottomAnchor, constant: 10),
                              editDisplayNameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                              editDisplayNameButton.widthAnchor.constraint(equalToConstant: 200),
                              editDisplayNameButton.heightAnchor.constraint(equalToConstant: 50)
                          ])
    }
    
}
