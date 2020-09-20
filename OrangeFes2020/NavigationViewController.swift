//
//  NavigationViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/08/22.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(named: "themeColor")
    
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        //文字の色
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
}
