//
//  SelfStickerTableViewCell.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 14.10.2020.
//

import UIKit

class SelfStickerTableViewCell: UITableViewCell {

  @IBOutlet weak var stikcerImageView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  func setImage(_ sticker:UIImage) {
    stikcerImageView.image = sticker
  }
}
