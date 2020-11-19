//
//  SelfSmallTableViewCell.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 14.10.2020.
//

import UIKit

class SelfSmallTableViewCell: UITableViewCell {

  @IBOutlet weak var longLabel: UILabel!
  @IBOutlet weak var shortLabel: UILabel!
  @IBOutlet weak var shortBubble: UIImageView!
  @IBOutlet weak var longBubble: UIImageView!
    @IBOutlet weak var backgroundShadowView: UIView!
    
  override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(_ text: String, isCustom: Bool = false) {
    shortBubble.isHidden = isCustom
    longLabel.isHidden = !isCustom
    shortLabel.isHidden = isCustom
    longBubble.isHidden = !isCustom
    longLabel.text = text
    }
    
    func configureShadow(removeShadow: Bool) {
        if removeShadow {
            UIView.animate(withDuration: 0.2) {
                self.backgroundShadowView.layer.opacity = 0
            }
        } else {
            backgroundShadowView.backgroundColor = .black
            backgroundShadowView.layer.opacity = 0.6
        }
    }
}
