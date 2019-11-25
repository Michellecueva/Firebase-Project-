//
//  MainFeedVC.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/23/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainFeedVC: UIViewController {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Feed"
        label.font = UIFont(name: "Arial", size: 45.0)
     label.textAlignment = .center
        return label
    }()
    
    lazy var usersCollectionView: UICollectionView = {
           let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
           layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
           layout.itemSize = CGSize(width: 200, height: 200)
           layout.scrollDirection = .vertical

           let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
           collectionView.register(MainFeedCell.self, forCellWithReuseIdentifier: "feedCell")
           collectionView.showsVerticalScrollIndicator = false
           collectionView.backgroundColor = .clear
           
           
           return collectionView
       }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        setSubviews()
        setConstraints()
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
    }
    
    //MARK: UI Setup
    
    private func setSubviews() {
         self.view.addSubview(titleLabel)
        self.view.addSubview(usersCollectionView)
     }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setUsersCollectionViewConstraints()
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
    
    private func setUsersCollectionViewConstraints() {
        usersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usersCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            usersCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            usersCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            usersCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
    }
    
}

extension MainFeedVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.usersCollectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? MainFeedCell else {
            print("didnt find cell")
            return UICollectionViewCell()
        }
        
        cell.userNameLabel.text = "Username"
        cell.upLoadedImage.image = UIImage(named: "noImage")
        
        return cell
    }
    
    
}
