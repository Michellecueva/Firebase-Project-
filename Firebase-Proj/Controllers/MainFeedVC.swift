//
//  MainFeedVC.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/23/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class MainFeedVC: UIViewController {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Feed"
        label.font = UIFont(name: "Arial", size: 45.0)
     label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        setSubviews()
        setConstraints()
    }
    
    //MARK: UI Setup
    
    private func setSubviews() {
         self.view.addSubview(titleLabel)
     }
    
    private func setConstraints() {
        setTitleLabelConstraints()
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
    
}
