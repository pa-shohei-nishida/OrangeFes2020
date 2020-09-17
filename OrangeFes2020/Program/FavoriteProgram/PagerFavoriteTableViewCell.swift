//
//  PagerFavoriteTableViewCell.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/07.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit

class PagerFavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var programImageView: UIImageView!
    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var programView: UIView!
    
    var userDefaults = UserDefaults.standard
    var currentProgramID:[String] = []
    
    var celectedFestivalID: String = ""
    var editableProgramID: [String] = []
    var currentViewType: String = ""
    var favoriteProgramID: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        loadUIDesign()
        super.layoutSubviews()
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
    
    
    
}
