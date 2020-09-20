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
    @IBOutlet weak var programView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadUIDesign()
    }
    
    func loadUIDesign() {
        programImageView.layer.masksToBounds = true
        programImageView.layer.cornerRadius = 10
        programImageView.contentMode = .scaleAspectFill
        
        programView.layer.cornerRadius = 10
        programView.layer.shadowOffset = CGSize(width: 2, height: 4)
        programView.layer.shadowColor = UIColor.black.cgColor
        programView.layer.shadowOpacity = 0.25
        programView.layer.shadowRadius = 4
    }
    
}
