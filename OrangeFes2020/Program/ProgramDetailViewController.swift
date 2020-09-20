//
//  ProgramDetailViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/10.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit

class ProgramDetailViewController: UIViewController {
    
    @IBOutlet weak var programTitleLabel: UILabel!
    @IBOutlet weak var programImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var data: (title: String, content: String, imageURL: String, id: String)!
    var stageData: (title: String, content: String, time: String, imageURL: String, id: String)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUIDesign()
        loadData()
    }
    
    func loadData() {
        if data != nil {
            programTitleLabel.text = data.title
            descriptionLabel.text = data.content
            //        descriptionLabel.text = "this is a\n \n tesssssssstaklsd;fjalk;fjeaiowfanznvcxm,.nioa;fejiwaskdfcnjkl;asdhjfqehrwjiofnaznvckxznv;ahjfu;qewnfjkasnfjashfe;qwnfasnv.m,zxnvjk;ajfjk;jwqioensxnzcvm.ncvas;fnio;weqfnhjkadsmnczmx,.ncjka;siod;fhniewoq;hnfcjadsk;cnxmz,.........nfjksadhfas;"
            programImageView.loadImageAsynchronously(url: data.imageURL)
        }
        if stageData != nil {
            programTitleLabel.text = stageData.title
            descriptionLabel.text = stageData.content
            //        descriptionLabel.text = "this is a\n \n tesssssssstaklsd;fjalk;fjeaiowfanznvcxm,.nioa;fejiwaskdfcnjkl;asdhjfqehrwjiofnaznvckxznv;ahjfu;qewnfjkasnfjashfe;qwnfasnv.m,zxnvjk;ajfjk;jwqioensxnzcvm.ncvas;fnio;weqfnhjkadsmnczmx,.ncjka;siod;fhniewoq;hnfcjadsk;cnxmz,.........nfjksadhfas;"
            programImageView.loadImageAsynchronously(url: stageData.imageURL)
        }
        
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadUIDesign() {
        programImageView.contentMode = .scaleAspectFill
        programImageView.layer.masksToBounds = true
        programImageView.layer.cornerRadius = 15
    }
}
