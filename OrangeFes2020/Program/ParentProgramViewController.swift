//
//  ParentViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/05.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ParentProgramViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userDefaults = UserDefaults.standard
    var presentIndex: Int = 0
    
    override func viewDidLoad() {
        loadDesign()
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(named: "SystemDarkBackground")
        //pagerview indexの初期値
        presentIndex = 0
    }
    
    //今開いているタブとindexをuserdefaultsに保存する
    override func viewWillAppear(_ animated: Bool) {
        userDefaults.set(currentIndex, forKey: "ProgramPresentIndex")
        userDefaults.set("ProgramPager", forKey: "currentPagerType")
        DispatchQueue.main.async {
                self.moveToViewController(at: 3, animated: false)
        }
        DispatchQueue.main.async {
                self.moveToViewController(at: 0, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "PagerView", bundle: nil).instantiateViewController(identifier: "ProgramShop")
        let child_2 = UIStoryboard(name: "PagerView", bundle: nil).instantiateViewController(identifier: "ProgramStage")
        let child_3 = UIStoryboard(name: "PagerView", bundle: nil).instantiateViewController(identifier: "ProgramExhibition")
        return [child_1, child_2, child_3]
    }
    
    func loadDesign() {
        self.settings.style.buttonBarBackgroundColor = UIColor(named: "SystemDarkBackground")
        self.settings.style.buttonBarItemBackgroundColor = UIColor(named: "SystemDarkBackground")
        self.settings.style.selectedBarBackgroundColor = UIColor(named: "Custom_themeColor")!
        self.settings.style.buttonBarItemTitleColor = UIColor(named: "Custom_themeColor")
        self.settings.style.selectedBarHeight = 4.0
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 10
        self.settings.style.buttonBarRightContentInset = 10
        self.settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16)
        
    }

}

