//
//  PagerTableViewCell.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/06.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit

class PagerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var programImageView: UIImageView!
    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var programView: UIView!
    
    var userDefaults = UserDefaults.standard
    var currentProgramID:[String] = []
    
    var celectedFestivalID: String = ""
    var currentViewType: String = ""
    var favoriteProgramID: [String] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //loadUIDesign()
        // Initialization code
    }
    
    override func layoutSubviews() {
        
        loadUIDesign()
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
        currentProgramID = userDefaults.array(forKey: "CurrentProgramID") as! [String]
        celectedFestivalID = userDefaults.string(forKey: "celectedFestivalID") ?? ""
        currentViewType = userDefaults.string(forKey: "currentViewType") ?? ""
        favoriteProgramID = userDefaults.array(forKey: "UDProgrammeKey,\(currentViewType),\(celectedFestivalID)") as? [String] ?? []
        
        print("currentProgramID", currentProgramID)
        print("sende.tag",[sender.tag])
        print("currentViewType", currentViewType)
        
        print("programPager")
        
        if currentProgramID == ["non"] {
            //do nothing
        } else {
            if favoriteProgramID.contains(currentProgramID[sender.tag]){
                print("removed")
                favoriteProgramID.remove(at: favoriteProgramID.firstIndex(of: currentProgramID[sender.tag])!)
                changeBlack()
                
            } else {
                print("append")
                favoriteProgramID.append(currentProgramID[sender.tag])
                changeOrange()
            }
        }
        
        userDefaults.set(favoriteProgramID, forKey: "UDProgrammeKey,\(currentViewType),\(celectedFestivalID)")
            
    }
    
    
    func loadUIDesign() {
        
        programView.layer.cornerRadius = 10
        
        programImageView.layer.masksToBounds = true
        programImageView.layer.cornerRadius = 10
        programImageView.contentMode = .scaleAspectFill
        
        programView.layer.shadowOffset = CGSize(width: 2, height: 4)
        programView.layer.shadowColor = UIColor.black.cgColor
        programView.layer.shadowOpacity = 0.25
        programView.layer.shadowRadius = 4
    
    }
    
    func changeBlack(){
        favoriteButton.setTitleColor(UIColor.black, for: .normal)
    }
    func changeOrange(){
        favoriteButton.setTitleColor(UIColor.orange, for: .normal)
    }
    
}
