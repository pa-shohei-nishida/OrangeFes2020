//
//  ProgramStageViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/06.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase

class ProgramStageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    let ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        programTableView.dataSource = self
        programTableView.delegate = self
        programTableView.register(UINib(nibName: "PagerTableViewCell", bundle: nil), forCellReuseIdentifier: "PagerTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //開いている学園祭のIDを取得
        celectedFestivalID = userDefaults.string(forKey: "celectedFestivalID") ?? ""
        userDefaults.set("Stage", forKey: "currentViewType")
        
        getProgramme()

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
        let UDColorTest: [String] = userDefaults.array(forKey: "UDProgrammeKey,\("Stage"),\(celectedFestivalID)") as? [String] ?? []
        
        // ここでcellのlabelに値を入れています。
        cell.programNameLabel.text = programName[indexPath.item]
        cell.favoriteButton.tag = indexPath.row
        //画像を表示させる
        let url = URL(string: programImageURL[indexPath.row])
        let imageView = cell.programImageView
        imageView?.sd_setImage(with: url, completed: nil)
        
        if UDColorTest.contains(programKey[indexPath.item]){
            cell.favoriteButton.setTitleColor(UIColor.orange, for: .normal)
        }else{
            cell.favoriteButton.setTitleColor(UIColor.black, for: .normal)
        }
        return cell
    }
    
    func getProgramme(){
        
        programName = []
        programKey = []
        programImageURL = []
        
        ref.child("学園祭一覧").child(celectedFestivalID).child("Programme").child("Stage").observe(.value, with: { (snapshot) in
            for item in (snapshot.children) {
                // 中身の取り出し
                let snapshot = item as! DataSnapshot
                let data = snapshot.value as! [String: Any]
                let getProgrammeName = data["ProgrammeName"] as! String
                let getProgrammeKey = data["ProgrammeKey"] as! String
                let getprogrammeImageURL = data["ProgrammeImageURL"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/schoolfestivalnavi.appspot.com/o/noimage.png?alt=media&token=df162152-5fca-4785-b9ef-e29f4783fd2e"

                self.programName.append(getProgrammeName)
                self.programKey.append(getProgrammeKey)
                self.programImageURL.append(getprogrammeImageURL)
                
                self.userDefaults.set(self.programKey, forKey: "CurrentProgramID")
                
            }
            self.programTableView.reloadData()
        })
    }
    
    // cellが押されたときに呼ばれる関数
    // 画面遷移の処理もここで書いている
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 押されたときのcellのlabelの文字列をViewControllerに渡したいので、一旦、giveDataに入れとく
        giveProgramKey = programKey[indexPath.row]
        userDefaults.set(giveProgramKey, forKey: "currentProgramID")
        
        // Segueを使った画面遷移を行う関数
        performSegue(withIdentifier: "DescriptionSegue", sender: nil)
    }
}

extension ProgramStageViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ステージ") // ButtonBarItemに表示される名前になります
    }
}
