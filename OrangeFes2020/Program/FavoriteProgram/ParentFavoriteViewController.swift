//
//  ParentFavoriteViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/06.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ParentFavoriteViewController: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var userDefaults = UserDefaults.standard
    var presentIndex: Int = 0
    
    override func viewDidLoad() {
        loadDesign()
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(named: "SystemDarkBackground")
        //tableviewをリロードするため
        DispatchQueue.main.async {
                self.moveToViewController(at: 3, animated: false)
        }
        DispatchQueue.main.async {
                self.moveToViewController(at: 0, animated: false)
        }

    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "PagerView", bundle: nil).instantiateViewController(identifier: "FavoriteShopTableViewController")
        let child_2 = UIStoryboard(name: "PagerView", bundle: nil).instantiateViewController(identifier: "FavoriteStageTableViewController")
        let child_3 = UIStoryboard(name: "PagerView", bundle: nil).instantiateViewController(identifier: "FavoriteExhibitionTableViewController")
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
