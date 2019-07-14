//
//  CustomTabBarViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/9/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController{
    
    //var tabBarItem = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .green
        
        //let selectedImage1 = UIImage(name: "")?.withRenderingMode(.alwaysOriginal)
        //let deselectedImage1 = UIImage(name: "")?.withRenderingMode(.alwaysOriginal)
        //tabBarItem = self.tabBar.items![0]
        //tabBarItem.image = deselectedImage1
        //tabBarItem.selectedImage = selectedImage1
        
        //tabBarItem = self.tabBar.items![1]
        
        //tabBarItem = self.tabBar.items![2]
        
        self.selectedIndex = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
