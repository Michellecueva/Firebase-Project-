//
//  MainFeedCell.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/24/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class MainFeedCell: UICollectionViewCell {
    var userNameLabel: UILabel = {
          let label = UILabel()
          label.numberOfLines = 0
          label.adjustsFontSizeToFitWidth = true
          label.textAlignment = .center
          return label
      }()
    
    var upLoadedImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
             super.init(frame: frame)
             self.contentView.addSubview(upLoadedImage)
           self.contentView.addSubview(userNameLabel)
             configureConstraints()
             
         }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func configureConstraints() {
               userNameLabel.translatesAutoresizingMaskIntoConstraints = false
               upLoadedImage.translatesAutoresizingMaskIntoConstraints = false
                   
                   NSLayoutConstraint.activate([
                       
                       upLoadedImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                       upLoadedImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                       upLoadedImage.widthAnchor.constraint(equalToConstant: 200),
                       upLoadedImage.heightAnchor.constraint(equalToConstant: 200),
                       
                       userNameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                       userNameLabel.bottomAnchor.constraint(equalTo: upLoadedImage.bottomAnchor),
                       
          
                   ])
               }
    
}
