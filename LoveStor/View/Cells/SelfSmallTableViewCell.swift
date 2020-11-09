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
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(_ text: String, isCustom:Bool = false) {
    shortBubble.isHidden = isCustom
    longLabel.isHidden = !isCustom
    shortLabel.isHidden = isCustom
    longBubble.isHidden = !isCustom
    longLabel.text = text
    }
}
