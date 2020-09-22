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
    let ref = Firestore.firestore()
    
    var data:[(title: String, content: String, imageURL: String, videoURL: String, id: String)] = []
    
    var programData:[(title: String, content: String, imageName: String, place: String)] = [
        (title: "美術部", content: "作品展示", imageName:"", place: ""),
        (title: "華道部", content: "廊下の一角に華道部のコーナー展示", imageName:"", place: ""),
        (title: "プロム", content: "ダンスパーティー。教室を飾り付け音楽を流しソーシャルディスタンスを保ちダンス", imageName:"", place: ""),
        (title: "法政国際男子3年", content: "動画上映会", imageName:"", place: ""),
        (title: "公式テニス部", content: "縁日", imageName:"", place: ""),
        (title: "放送部", content: "作成したビデオの放映・できたら休憩室としても開きたいです", imageName:"", place: ""),
        (title: "有志演劇", content: "演劇のビデオを撮影して、それを上映する予定です", imageName:"", place: ""),
        (title: "クイズ研究会（非公認）", content: "早押し体験会", imageName:"", place: "")
    ]
    
    var giveData: (title: String, content: String, imageURL: String, videoURL: String, id: String)!

    var descriptionView = ProgramDetailViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        programTableView.dataSource = self
        programTableView.delegate = self
        programTableView.register(UINib(nibName: "PagerTableViewCell", bundle: nil), forCellReuseIdentifier: "PagerTableViewCell")
        programTableView.reloadData()
    }
    
    func getData() {
        data = []
        ref.collection("shop").getDocuments() {(snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in (snapshot?.documents)! {
                    let id:String = document.documentID
                    guard let title = document.data()["title"] as? String else { return }
                    guard let content = document.data()["content"] as? String else { return }
                    let imageURL = document.data()["imageURL"] as? String ?? ""
                    let videoURL  = document.data()["videoURL"] as? String ?? ""
                    self.data.append((title: title, content: content, id: id, imageURL: imageURL, videoURL: videoURL))
                    self.programTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PagerTableViewCell", for: indexPath as IndexPath) as! PagerTableViewCell
        cell.timeLabel.isEnabled = false
        cell.timeLabel.isHidden = true
        cell.programNameLabel.text = data[indexPath.item].title
        cell.programImageView?.loadImageAsynchronously(url: data[indexPath.row].imageURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        giveData = data[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "ProgramDetailViewController") as! ProgramDetailViewController
        vc.data = giveData
        self.present(vc, animated: true, completion: nil)
    }
}

extension ProgramShopViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "出展") // ButtonBarItemに表示される名前になります
    }
}
