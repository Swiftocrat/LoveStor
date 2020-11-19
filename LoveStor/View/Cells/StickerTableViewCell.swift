//
//  StickerTableViewCell.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 14.10.2020.
//

import UIKit

class StickerTableViewCell: UITableViewCell {

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
    
    func configureShadow(removeShadow: Bool) {
        if removeShadow {
            UIView.animate(withDuration: 0.2) {
                self.backgroundShadowView.layer.opacity = 0
            }
        }
    }
}
