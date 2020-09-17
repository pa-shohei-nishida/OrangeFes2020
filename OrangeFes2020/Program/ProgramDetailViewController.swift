//
//  ProgramDetailViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/10.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit
import Firebase

class ProgramDetailViewController: UIViewController {
    
    @IBOutlet weak var programTitleLabel: UILabel!
    @IBOutlet weak var programImageView: UIImageView!
    @IBOutlet weak var programDescriptionTextView: UITextView!
    
    var userDefaults = UserDefaults.standard
    let ref = Database.database().reference()
    
    var celectedFestivalID: String = ""
    var currentViewtype: String = ""
    var currentProgramID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        celectedFestivalID = userDefaults.string(forKey: "celectedFestivalID") ?? ""
        currentViewtype = userDefaults.string(forKey: "currentViewType") ?? ""
        currentProgramID = userDefaults.string(forKey: "currentProgramID") ?? ""
        loadProgram()
        loadUIDesign()
    }
    
    func loadProgram(){
        ref.child("学園祭一覧").child(celectedFestivalID).child("Programme").child(currentViewtype).child(currentProgramID).observe(.value, with: { [weak self](snapshot) -> Void in
            
            let getProgrammeName = String(describing: snapshot.childSnapshot(forPath: "ProgrammeName").value!)
            let getProgrammeDescription = String(describing: snapshot.childSnapshot(forPath: "ProgrammeDescription").value!)
            let getProgrammeImageURL = String(describing: snapshot.childSnapshot(forPath: "ProgrammeImageURL").value ?? "https://firebasestorage.googleapis.com/v0/b/schoolfestivalnavi.appspot.com/o/noimage.png?alt=media&token=df162152-5fca-4785-b9ef-e29f4783fd2e")
            let getProgrammeCategory = String(describing: snapshot.childSnapshot(forPath: "Category").value!)
            
            let url = URL(string: getProgrammeImageURL)
            
            self?.programTitleLabel.text = getProgrammeName
            self?.programDescriptionTextView.text = getProgrammeDescription
            self?.programImageView.sd_setImage(with: url, completed: nil)
    
        })
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadUIDesign() {
        programDescriptionTextView.layer.cornerRadius = 10.0
        programDescriptionTextView.layer.masksToBounds = true
        
        programImageView.contentMode = .scaleAspectFill
        programImageView.layer.masksToBounds = true
        programImageView.layer.cornerRadius = 15
    }
}
