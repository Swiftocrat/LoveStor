//
//  StoriesViewController.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 13.10.2020.
//

import UIKit

class StoriesViewController: UIViewController {

  @IBOutlet weak var buttonCenter: NSLayoutConstraint!
  @IBOutlet weak var buttonW: NSLayoutConstraint!
  @IBOutlet weak var heartW: NSLayoutConstraint!
  @IBOutlet weak var heartBtn:UIImageView!
  @IBOutlet weak var imsgeW: NSLayoutConstraint!
  @IBOutlet weak var imageH: NSLayoutConstraint!
  @IBOutlet var stoppedHeart:[UIImageView]!
  @IBOutlet var redHearts:[UIImageView]!
  @IBOutlet weak var redHeartImage: UIImageView!
  @IBOutlet weak var descrLabel: UILabel!
  @IBOutlet weak var background: UIImageView! {
    didSet {
      let horizontalEffect = UIInterpolatingMotionEffect(
          keyPath: "center.x",
          type: .tiltAlongHorizontalAxis)
      horizontalEffect.minimumRelativeValue = -50
      horizontalEffect.maximumRelativeValue = 50

      let verticalEffect = UIInterpolatingMotionEffect(
          keyPath: "center.y",
          type: .tiltAlongVerticalAxis)
      verticalEffect.minimumRelativeValue = -50
      verticalEffect.maximumRelativeValue = 50

      let effectGroup = UIMotionEffectGroup()
      effectGroup.motionEffects = [ horizontalEffect,
                                    verticalEffect ]

      background.addMotionEffect(effectGroup)
    }
  }
  @IBOutlet weak var matchLabel: UILabel!
  @IBOutlet weak var mainButton: GradientView!
  @IBOutlet weak var storyImageView: UIImageView!
  @IBOutlet weak var storyContainerView: UIView! {
    didSet {
      storyContainerView.layer.cornerRadius = storyContainerView.bounds.size.width / 2
      storyContainerView.layer.masksToBounds = true
    }
  }
  @IBOutlet weak var backButton: UIImageView! {
    didSet {
      backButton.isUserInteractionEnabled = true
      backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnBack)))
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    storyImageView.makeCircle()
    storyContainerView.makeCircle()
    mainButton.layer.cornerRadius = 33
    matchLabel.animate(newText: "Its Match", characterDelay: 0.2)
    UIView.animate(withDuration: 1.0) {
      self.descrLabel.alpha = 1
    }
    
    UIView.animate(withDuration: 6.5, delay: 0.4,
                   options: [.curveEaseOut],
      animations: {
        self.redHearts.forEach {
          $0.center.y += self.view.bounds.height + 500
        }
      },
      
      completion: nil
    )
    
    storyImageView.rotate(3)
    UIView.animate(withDuration: 2.5, delay: 0,
                   options: [.curveEaseOut],
      animations: {
        self.imageH.constant = self.imageH.constant * 9
        self.imsgeW.constant = self.imsgeW.constant * 9
        self.mainButton.alpha = 1
        self.buttonCenter.constant = 0
        self.view.layoutIfNeeded()
      },
      
      completion: { _ in
        UIView.animate(withDuration: 1.5, delay: 0,
                       options: [.curveEaseOut],
          animations: {
            self.storyContainerView.backgroundColor = .white
          },
          
          completion: nil
        )
      }
    )
    
    UIView.animate(withDuration: 2.5, delay: 0,
      options: [.curveEaseIn],
      animations: {
        self.mainButton.alpha = 1
        self.buttonCenter.constant = 0
        self.view.layoutIfNeeded()
      },
      completion: nil
    )

    UIView.animate(withDuration: 2.5, delay: 0.4,
                   options: [.curveEaseOut],
      animations: {
        self.stoppedHeart.forEach {
          switch $0.tag {
            case 1: $0.center.y += (self.view.bounds.height / 4.435) + 197
            case 2: $0.center.y += (self.view.bounds.height / 4.435) + 230
            case 3: $0.center.y += (self.view.bounds.height / 4.435) + 193
            case 4: $0.center.y += (self.view.bounds.height / 2.4) + 378
            case 5: $0.center.y += (self.view.bounds.height / 1.9) + 509
            case 6: $0.center.y += (self.view.bounds.height / 1.7) + 538
            case 7: $0.center.y += (self.view.bounds.height / 1.85) + 431
            default: $0.center.y += self.view.bounds.height + 500
          }
        }
      },
      completion: {_ in
        self.stoppedHeart.forEach { heart in
          switch heart.tag {
          case 1,2,5,6: heart.heart()
          default:  UIView.animate(withDuration: 1.5, delay: 0,
                                   options: [.repeat,.autoreverse],
                                   animations: {
                                    heart.alpha = 0.0
                                   },
                                   completion: nil
          )
          }
        }
      }
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  @objc func returnBack() {
    navigationController?.popViewController(animated: true)
  }
}








