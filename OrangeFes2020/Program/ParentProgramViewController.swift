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
    
    override func viewDidLoad() {
        loadDesign()
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(named: "SystemDarkBackground")
    }
    
    //今開いているタブとindexをuserdefaultsに保存する
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
                self.moveToViewController(at: 2, animated: false)
        }
        DispatchQueue.main.async {
                self.moveToViewController(at: 0, animated: false)
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "PagerView", bundle: nil).instantiateViewController(identifier: "ProgramShop")
        let child_2 = UIStoryboard(name: "PagerView", bundle: nil).instantiateViewController(identifier: "ProgramStage")
        return [child_1, child_2]
    }
    
    func loadDesign() {
        self.settings.style.buttonBarBackgroundColor = UIColor(named: "themeColor")
        self.settings.style.buttonBarItemBackgroundColor = UIColor(named: "themeColor")
        self.settings.style.selectedBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemTitleColor = UIColor.white
        self.settings.style.selectedBarHeight = 4.0
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 10
        self.settings.style.buttonBarRightContentInset = 10
        self.settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16)
        
    }

}

