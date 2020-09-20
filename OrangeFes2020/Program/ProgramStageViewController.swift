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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var userDefaults = UserDefaults.standard
    let ref = Firestore.firestore()
    
    var stageData:[(title: String, content: String, time: String, imageURL: String, id: String)] = []
    var giveStageData: (title: String, content: String, time: String, imageURL: String, id: String)!

    var descriptionView = ProgramDetailViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if segmentedControl.selectedSegmentIndex == 0 {
            getDay1Data()
        } else {
            getDay2Data()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        programTableView.dataSource = self
        programTableView.delegate = self
        programTableView.register(UINib(nibName: "PagerTableViewCell", bundle: nil), forCellReuseIdentifier: "PagerTableViewCell")
        programTableView.reloadData()
    }
    
    func getDay1Data() {
        stageData = []
        ref.collection("day1Stage").order(by: "time", descending: false).getDocuments() {(snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                self.programTableView.reloadData()
            } else {
                for document in (snapshot?.documents)! {
                    let id:String = document.documentID
                    guard let title = document.data()["title"] as? String else { return }
                    let time = document.data()["time"] as? String ?? "設定されていません"
                    let content = document.data()["content"] as? String ?? "設定されていません"
                    let imageURL = document.data()["imageURL"] as? String ?? ""
                    self.stageData.append((title: title, content: content, time: time, id: id, imageURL: imageURL))
                    self.programTableView.reloadData()
                }
            }
        }
    }
    
    func getDay2Data() {
        stageData = []
        ref.collection("nightStage").order(by: "time", descending: false).getDocuments() {(snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                self.programTableView.reloadData()
            } else {
                for document in (snapshot?.documents)! {
                    let id:String = document.documentID
                    guard let title = document.data()["title"] as? String else { return }
                    let time = document.data()["time"] as? String ?? "設定されていません"
                    let content = document.data()["content"] as? String ?? "設定されていません"
                    let imageURL = document.data()["imageURL"] as? String ?? ""
                    self.stageData.append((title: title, content: content, time: time, id: id, imageURL: imageURL))
                    self.programTableView.reloadData()
                }
            }
        }
        
    }
    
    @IBAction func segmentTap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getDay1Data()
        case 1:
            getDay2Data()
        default:
            getDay2Data()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PagerTableViewCell", for: indexPath as IndexPath) as! PagerTableViewCell
        
        cell.timeLabel.text = stageData[indexPath.item].time
        cell.programNameLabel.text = stageData[indexPath.item].title
        cell.programImageView?.loadImageAsynchronously(url: stageData[indexPath.row].imageURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        giveStageData = stageData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "ProgramDetailViewController") as! ProgramDetailViewController
        vc.stageData = giveStageData
        self.present(vc, animated: true, completion: nil)
    }
}

extension ProgramStageViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ステージ") // ButtonBarItemに表示される名前になります
    }
}

