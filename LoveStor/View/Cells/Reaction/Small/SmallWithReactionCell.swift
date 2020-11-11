//
//  SmallWithReactionCell.swift
//  LoveStor
//
//  Created by ****** ****** on 11.11.2020.
//

import UIKit

class SmallWithReactionCell: UITableViewCell {

    @IBOutlet weak var reactionButton: UIButton!
    @IBOutlet weak var rectionButtonHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    @IBAction func reactionButtonTapped(_ sender: Any) {
    }
}
