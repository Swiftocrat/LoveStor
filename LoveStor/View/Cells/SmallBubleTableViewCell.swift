//
//  SmallBubleTableViewCell.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 14.10.2020.
//

import UIKit

class SmallBubleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundShadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundShadowView.backgroundColor = .black
        backgroundShadowView.layer.opacity = 0.6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    override func layoutSubviews() {
        super.layoutSubviews()
    
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left:  0, bottom: 0, right: 0))
       contentView.frame = contentView.frame.offsetBy(dx: 0, dy: 0)
    }
    
//    func configureCell(showsReactionButton: Bool) {
//        if !showsReactionButton {
//            reactionButton.isHidden = true
//            rectionButtonHeightConstraint.constant = 0
//        }
//    }
    
    func configureShadow(removeShadow: Bool) {
        if removeShadow {
            UIView.animate(withDuration: 0.2) {
                self.backgroundShadowView.layer.opacity = 0
            }
        }
    }
}
