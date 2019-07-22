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
        UITabBar.appearance().backgroundColor = UIColor.white
        self.selectedIndex = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
