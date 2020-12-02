//
//  HoroscopeSignTableViewCell.swift
//  LoveStor
//
//  Created by ****** ****** on 26.11.2020.
//

import UIKit

class HoroscopeSignTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var signImageView: UIImageView!
    @IBOutlet weak var horoscopeSignNameLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            selectionImageView.image = UIImage(named: "selectedCircleSelectedIcon")
            selectionView.isHidden = false
        } else {
            selectionImageView.image = UIImage(named: "selectionCircleIcon")
            selectionView.isHidden = true
        }
    }
    
    func showSelection() {
        selectionImageView.image = UIImage(named: "selectedCircleSelectedIcon")
    }
}
