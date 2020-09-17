//
//  ProgramExhibitionViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/06.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProgramStageTimeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var programTableView: UITableView!
    
    var userDefaults = UserDefaults.standard
    
    var celectedFestivalID: String = ""
    
    var festivalName: String = ""
    
    var programName:[String] = []
    var programKey:[String] = []
    
    var programImageURL:[String] = []
    
    var giveProgramKey: String = ""
    var giveFestivalUID: String = ""
    var giveProgramType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        programTableView.dataSource = self
        programTableView.delegate = self
        programTableView.register(UINib(nibName: "PagerTableViewCell", bundle: nil), forCellReuseIdentifier: "PagerTableViewCell")
        print("pyon pyon")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //開いている学園祭のIDを取得
        celectedFestivalID = userDefaults.string(forKey: "celectedFestivalID") ?? ""
        userDefaults.set("Exhibition", forKey: "currentViewType")

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    // sectionごとのcellの数を返す関数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programKey.count
    }
    
    // cellの情報を書き込む関数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PagerTableViewCell", for: indexPath as IndexPath) as! PagerTableViewCell
        
        //UserDefaultの情報を取得
        let UDColorTest: [String] = userDefaults.array(forKey: "UDProgrammeKey,\("Exhibition"),\(celectedFestivalID)") as? [String] ?? []
        
        // ここでcellのlabelに値を入れています。
        cell.programNameLabel.text = programName[indexPath.item]
        cell.favoriteButton.tag = indexPath.row

        return cell
    }
    
    // cellが押されたときに呼ばれる関数
    // 画面遷移の処理もここで書いている
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        giveProgramKey = programKey[indexPath.row]
        userDefaults.set(giveProgramKey, forKey: "currentProgramID")
        
        // Segueを使った画面遷移を行う関数
        performSegue(withIdentifier: "DescriptionSegue", sender: nil)
    }
}

extension ProgramStageTimeViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "展示") // ButtonBarItemに表示される名前になります
    }
}
