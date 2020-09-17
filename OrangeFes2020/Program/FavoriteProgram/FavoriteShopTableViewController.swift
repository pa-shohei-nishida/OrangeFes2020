//
//  FavoriteShopTableViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/07.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase

class FavoriteShopTableViewController: UITableViewController {
    
    var userDefaults = UserDefaults.standard
    
    var celectedFestivalID: String = ""
    
    var UDFavoriteProgrammeKey: [String] = []
    var favoriteProgramName: [String] = []
    var programKey: [String] = []
    
    
    var favoriteProgrammeImageURL:[String] = []
    
    var giveFavoriteProgramKey = ""
    var giveProgrammeType: String = ""
    
    var firstAppear = true
    var appearCount: Int = 0
    
    let ref = Database.database().reference()


    override func viewWillAppear(_ animated: Bool) {
        userDefaults.set("Shop", forKey: "currentViewType")
        //強行突破
        appearCount += 1
        if appearCount > 1 {
            celectedFestivalID = userDefaults.string(forKey: "celectedFestivalID") ?? ""
            
            getFavoriteProgramme()
            tableView.reloadData()
        }
        
    }

    // cellの高さを返す関数
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programKey.count
    }
    
    // cellの情報を書き込む関数
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PagerFavoriteTableViewCell", for: indexPath) as! PagerFavoriteTableViewCell
        
        celectedFestivalID = userDefaults.string(forKey: "celectedFestivalID") ?? ""
        let UDColorTestProgramme = userDefaults.array(forKey: "UDProgrammeKey,\("Shop"),\(celectedFestivalID)") as? [String] ?? []
        
        // ここでcellのlabelに値を入れています。//ここに新たな文字をい入れる
        cell.programNameLabel.text = favoriteProgramName[indexPath.item]
        cell.favoriteButton.tag = indexPath.row
        
        let url = URL(string: favoriteProgrammeImageURL[indexPath.row])
        let imageView = cell.programImageView
        imageView?.sd_setImage(with: url, completed: nil)
        
        if UDColorTestProgramme.contains(programKey[indexPath.item]){
            cell.favoriteButton.setTitleColor(UIColor.orange, for: .normal)
        } else {
            cell.favoriteButton.setTitleColor(UIColor.black, for: .normal)
        }

        return cell
    }
    
    // cellが押されたときに呼ばれる関数
    // 画面遷移の処理もここで書いている
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        giveFavoriteProgramKey = programKey[indexPath.item]
        userDefaults.set(giveFavoriteProgramKey, forKey: "currentProgramID")
        
        performSegue(withIdentifier: "DescriptionSegue", sender: nil)
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        print("button pressed")
        print(sender.tag)
        
        var getUDProgrammeKey:[String] = userDefaults.array(forKey: "UDProgrammeKey,\("Shop"),\(celectedFestivalID)") as? [String] ?? []
        
        //UDProgrammeNameにProgrammeNameを代入している
        func changeBlack(){
            sender.setTitleColor(UIColor.black, for: .normal)
        }
        func changeOrange(){
            sender.setTitleColor(UIColor.orange, for: .normal)
        }
        
        if getUDProgrammeKey.contains(programKey[sender.tag]){
            getUDProgrammeKey.remove(at: getUDProgrammeKey.firstIndex(of: programKey[sender.tag])!)
            changeBlack()
            
        } else {
            getUDProgrammeKey.append(programKey[sender.tag])
            changeOrange()
        }
        userDefaults.set(getUDProgrammeKey, forKey: "UDProgrammeKey,\("Shop"),\(celectedFestivalID)")
    }
    
    
    func getFavoriteProgramme(){
        
        favoriteProgramName = []
        programKey = []
        favoriteProgrammeImageURL = []
        
        UDFavoriteProgrammeKey = userDefaults.array(forKey: "UDProgrammeKey,\("Shop"),\(celectedFestivalID)") as? [String] ?? []
        //bugあり
        if UDFavoriteProgrammeKey == [] {
            favoriteProgramName = []
            programKey = []
            favoriteProgrammeImageURL = []
        } else {
            for item in UDFavoriteProgrammeKey {
                ref.child("学園祭一覧").child(celectedFestivalID).child("Programme").child("Shop").child(item).observeSingleEvent(of: .value, with: { (snapshot) in
                    let getFavoriteProgrammeKey = String(describing: snapshot.childSnapshot(forPath: "ProgrammeKey").value ?? "")
                    let getFavoriteProgrammeName = String(describing: snapshot.childSnapshot(forPath: "ProgrammeName").value ?? "")
                    let getFavoriteProgrammeImageURL = String(describing: snapshot.childSnapshot(forPath: "ProgrammeImageURL").value ?? "")
                    
                    self.favoriteProgramName.append(getFavoriteProgrammeName)
                    self.programKey.append(getFavoriteProgrammeKey)
                    self.favoriteProgrammeImageURL.append(getFavoriteProgrammeImageURL)
                    self.tableView.reloadData()
                })
                
            }
        }
    }
    
}

extension FavoriteShopTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "企画一覧") // ButtonBarItemに表示される名前になります
    }
}
