//
//  SmallWithReactionCell.swift
//  LoveStor
//
//  Created by ****** ****** on 11.11.2020.
//

import Popover
import UIKit

class SmallWithReactionCell: UITableViewCell {

    @IBOutlet weak var reactionButton: UIButton!
    @IBOutlet weak var rectionButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundShadowView: UIView!
    
    weak var delegate: ReactionDelegate?
    var removeShadowClosure: () -> Void = {}
    
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
    
    @IBAction func reactionButtonTapped(_ sender: Any) {
        removeShadowClosure()
//        delegate?.hideBackgroundShadow()
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 106))
        let happySmileButton = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        let positiveSmileButton = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 36, height: 82))
        stackView.axis = .vertical
        aView.addSubview(stackView)
        stackView.center = aView.center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(happySmileButton)
        stackView.addArrangedSubview(positiveSmileButton)
        happySmileButton.setImage(UIImage(named: "smileHappy"), for: .normal)
        positiveSmileButton.setImage(UIImage(named: "smilePositive"), for: .normal)
        let options = [
          .type(.up),
          .cornerRadius(8),
          .animationIn(0.3),
          .arrowSize(CGSize(width: 10.0, height: 4.0))
          ] as [PopoverOption]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        let setHappySmile = UIAction { _ in
            self.reactionButton.setImage(happySmileButton.image(for: .normal), for: .normal)
            self.reactionButton.isUserInteractionEnabled = false
            popover.dismiss()
            self.delegate?.showPopup()
        }
        let setPositiveSmile = UIAction { _ in
            self.reactionButton.setImage(happySmileButton.image(for: .normal), for: .normal)
            self.reactionButton.isUserInteractionEnabled = false
            popover.dismiss()
            self.delegate?.showPopup()
        }
        if #available(iOS 14.0, *) {
            happySmileButton.addAction(setHappySmile, for: .touchUpInside)
            positiveSmileButton.addAction(setPositiveSmile, for: .touchUpInside)
            
        }
        popover.show(aView, fromView: self.reactionButton)
    }
}
