//
//  StickerCollectionViewCell.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 14.10.2020.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var stickerImage: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func configureCell(_ image: UIImage) {
    stickerImage.image = image
  }

}
