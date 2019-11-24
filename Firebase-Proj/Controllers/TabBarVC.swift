//
//  TabBarVC.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/23/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    lazy var feedVC = UINavigationController(rootViewController: MainFeedVC())
    lazy var uploadVC = UploadImageVC()
    lazy var profileVC = ProfileVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        uploadVC.tabBarItem = UITabBarItem(title: "Upload Image", image: UIImage(systemName: "square.and.arrow.up"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        self.viewControllers = [feedVC,uploadVC,profileVC]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
