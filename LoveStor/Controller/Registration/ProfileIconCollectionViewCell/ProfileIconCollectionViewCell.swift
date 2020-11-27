//
//  ProfileIconCollectionViewCell.swift
//  LoveStor
//
//  Created by ****** ****** on 27.11.2020.
//

import UIKit

class ProfileIconCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            selectionImageView.isHidden = isSelected ? false : true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
