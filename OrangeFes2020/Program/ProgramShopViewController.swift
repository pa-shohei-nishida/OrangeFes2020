//
//  ProgramShopViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/06.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase

class ProgramShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var programTableView: UITableView!
    
    var userDefaults = UserDefaults.standard
    
    var celectedFestivalID: String = ""
    
    var festivalName: String = ""
    
    var programmeName:[String] = []
    var programKey:[String] = []
    
    var programmeImageURL:[String] = []
    
    var giveProgramKey: String = ""
    var giveFestivalUID: String = ""
    var giveProgrammeType: String = ""
    
    var programData:[(title: String, content: String, category: String, place: String, id: String, imageReference: String, imageURL: String)] = []
    var giveProgramData: (title: String, content: String, category: String, place: String, id: String, imageReference: String, imageURL: String)!
    
    let ref = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        programTableView.dataSource = self
        programTableView.delegate = self
        programTableView.register(UINib(nibName: "PagerTableViewCell", bundle: nil), forCellReuseIdentifier: "PagerTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //開いている学園祭のIDを取得
        celectedFestivalID = userDefaults.string(forKey: "celectedFestivalID") ?? ""
        userDefaults.set("Shop", forKey: "currentViewType")
        getData()
        
        programTableView.reloadData()
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
        
        let UDColorTest: [String] = userDefaults.array(forKey: "UDProgrammeKey,\("Shop"),\(celectedFestivalID)") as? [String] ?? []
        
        cell.programNameLabel.text = programData[indexPath.item].title
        cell.programImageView?.loadImageAsynchronously(url: programData[indexPath.row].imageURL)

//        cell.programNameLabel.text = programmeName[indexPath.item]
        cell.favoriteButton.tag = indexPath.row
//        //画像を表示させる
//        let url = URL(string: programmeImageURL[indexPath.row])
//        let imageView = cell.programImageView
//        imageView?.sd_setImage(with: url, completed: nil)
        
        if UDColorTest.contains(programKey[indexPath.item]){
            cell.favoriteButton.setTitleColor(UIColor.orange, for: .normal)
        }else{
            cell.favoriteButton.setTitleColor(UIColor.black, for: .normal)
        }
        return cell
    }
    
    func getData() {
        programData = []
        ref.collection(celectedFestivalID).document("program").collection("shop").getDocuments() {(snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in (snapshot?.documents)! {
                    let id:String = document.documentID
                    guard let title = document.data()["title"] as? String else { return }
                    guard let content = document.data()["content"] as? String else { return }
                    guard let category = document.data()["category"] as? String else { return }
                    guard let place = document.data()["place"] as? String else { return }
                    guard let imageReference = document.data()["imageReference"] as? String else { return }
                    guard let imageURL = document.data()["imageURL"] as? String else { return }
                    self.programData.append((title: title, content: content, category: category, place: place, id: id, imageReference: imageReference, imageURL: imageURL))
                    self.programTableView.reloadData()
                }
            }
        }
    }
//    func getProgramme(){
//
//        programmeName = []
//        programKey = []
//        programmeImageURL = []
//
//        ref.child("学園祭一覧").child(celectedFestivalID).child("Programme").child("Shop").observe(.value, with: { (snapshot) in
//            print("212")
//            for item in (snapshot.children) {
//                // 中身の取り出し
//                let snapshot = item as! DataSnapshot
//                let data = snapshot.value as! [String: Any]
//                let getProgrammeName = data["ProgrammeName"] as! String
//                let getProgrammeKey = data["ProgrammeKey"] as! String
//                let getprogrammeImageURL = data["ProgrammeImageURL"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/schoolfestivalnavi.appspot.com/o/noimage.png?alt=media&token=df162152-5fca-4785-b9ef-e29f4783fd2e"
//
//                self.programmeName.append(getProgrammeName)
//                self.programKey.append(getProgrammeKey)
//                self.programmeImageURL.append(getprogrammeImageURL)
//
//                self.userDefaults.set(self.programKey, forKey: "CurrentProgramID")
//            }
//            if self.programKey == [] {
//                self.programmeName.append("設定されていません")
//                self.programKey.append("non")
//                self.programmeImageURL.append("https://firebasestorage.googleapis.com/v0/b/schoolfestivalnavi.appspot.com/o/noimage.png?alt=media&token=df162152-5fca-4785-b9ef-e29f4783fd2e")
//                self.userDefaults.set(self.programKey, forKey: "CurrentProgramID")
//            }
//            self.programTableView.reloadData()
//        })
//    }
    
    // cellが押されたときに呼ばれる関数
    // 画面遷移の処理もここで書いている
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        giveProgramKey = programKey[indexPath.row]
        if giveProgramKey == "non" {
            // do nothing
        } else {
            userDefaults.set(giveProgramKey, forKey: "currentProgramID")
            performSegue(withIdentifier: "DescriptionSegue", sender: nil)
        }
    }
    
}

extension ProgramShopViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "企画一覧") // ButtonBarItemに表示される名前になります
    }
}
