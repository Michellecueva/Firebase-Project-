//
//  DetailViewController.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/24/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var titleLabel : UILabel = {
           let label = UILabel()
           label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           label.text = "Image Detail"
           label.font = UIFont(name: "Arial", size: 45.0)
        label.textAlignment = .center
           return label
       }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        return imageView
    }()
    
    lazy var submittedByLabel : UILabel = {
           let label = UILabel()
           label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           label.text = "Submitted by: "
           label.font = UIFont(name: "Arial", size: 20)
           return label
       }()
    
    lazy var createdAtLabel : UILabel = {
             let label = UILabel()
             label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
             label.text = "Created at: "
             label.font = UIFont(name: "Arial", size: 17)
             return label
         }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setSubviews()
        setConstraints()
    }
    
    
       //MARK: UI Setup
    
    private func setSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(imageView)
        self.view.addSubview(submittedByLabel)
        self.view.addSubview(createdAtLabel)
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setImageViewConstraints()
        setSubmittedByLabelConstraints()
        setCreatedAtLabelConstraints()
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
    
    private func setSubmittedByLabelConstraints() {
        submittedByLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                submittedByLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
                submittedByLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 30),
                submittedByLabel.widthAnchor.constraint(equalToConstant: 200),
                submittedByLabel.heightAnchor.constraint(equalToConstant: 50)
               ])
    }
    
    private func setCreatedAtLabelConstraints() {
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                createdAtLabel.topAnchor.constraint(equalTo: self.submittedByLabel.bottomAnchor),
                createdAtLabel.leadingAnchor.constraint(equalTo: submittedByLabel.leadingAnchor),
                createdAtLabel.widthAnchor.constraint(equalToConstant: 200),
                createdAtLabel.heightAnchor.constraint(equalToConstant: 50)
               ])
    }
    

}
