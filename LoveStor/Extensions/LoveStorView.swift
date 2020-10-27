//
//  LoveStorView.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 28.10.2020.
//

import Foundation
import UIKit


extension UIView {
  func addParallaxToView() {
      let amount = 100

      let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
      horizontal.minimumRelativeValue = -amount
      horizontal.maximumRelativeValue = amount

      let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
      vertical.minimumRelativeValue = -amount
      vertical.maximumRelativeValue = amount

      let group = UIMotionEffectGroup()
      group.motionEffects = [horizontal, vertical]
      self.addMotionEffect(group)
  }
  
  func rotate(_ repeats: Float? = nil) {
      let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
      rotation.toValue = NSNumber(value: Double.pi * 2)
      rotation.duration = 1
      rotation.isCumulative = true
      rotation.repeatCount = repeats ?? Float.greatestFiniteMagnitude
      self.layer.add(rotation, forKey: "rotationAnimation")
  }
  
  func stopRotation() {
    self.layer.removeAnimation(forKey: "rotationAnimation")
  }
  
  func makeCircle() {
    self.layer.cornerRadius = self.bounds.size.width / 2
    self.layer.masksToBounds = true
  }
  
  func pulsate() {
    layer.add(CASpringAnimation(keyPath: "transform.scale").then {
      $0.duration = 0.1
      $0.fromValue = 0.98
      $0.toValue = 1.0
      $0.autoreverses = false
      $0.initialVelocity = 0.5
      $0.damping = 1.0
    }, forKey: nil)
  }
  
  func heart() {
    layer.add(CASpringAnimation(keyPath: "transform.scale").then {
      $0.duration = 0.7
      $0.fromValue = 0.90
      $0.toValue = 1.0
      $0.autoreverses = false
      $0.initialVelocity = 0.5
      $0.damping = 1.0
      $0.repeatCount = 3000
    }, forKey: nil)
  }
  
  func grow() {
    layer.add(CASpringAnimation(keyPath: "transform.scale").then {
      $0.duration = 4.7
      $0.fromValue = 0.2
      $0.toValue = 1.0
      $0.autoreverses = false
      $0.damping = 1.0
    }, forKey: nil)
  }
  
  func makeGlow(addShadow: Bool = true) {
    self.layer.do {
      if addShadow {
        $0.shadowOffset = .zero
        $0.shadowColor = UIColor.yellow.cgColor
        $0.shadowRadius = 2
        $0.shadowOpacity = 1
        $0.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      } else {
        $0.shadowOpacity = 0
      }
      
    }
  }
  
  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 1, height: 1)
    layer.shadowRadius = 1

//    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//    layer.shouldRasterize = true
//    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}


extension UILabel {
  
  func animate(newText: String, characterDelay: TimeInterval) {
    
    DispatchQueue.main.async {
      
      self.text = ""
      
      for (index, character) in newText.enumerated() {
        DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
          self.text?.append(character)
        }
      }
    }
  }
  
}



extension UITableView {
    func scrollTableViewToBottom(animated: Bool) {
        guard let dataSource = dataSource else { return }

        var lastSectionWithAtLeasOneElements = (dataSource.numberOfSections?(in: self) ?? 1) - 1

        while dataSource.tableView(self, numberOfRowsInSection: lastSectionWithAtLeasOneElements) < 1 {
            lastSectionWithAtLeasOneElements -= 1
        }

        let lastRow = dataSource.tableView(self, numberOfRowsInSection: lastSectionWithAtLeasOneElements) - 1

        guard lastSectionWithAtLeasOneElements > -1 && lastRow > -1 else { return }

        let bottomIndex = IndexPath(item: lastRow, section: lastSectionWithAtLeasOneElements)
        scrollToRow(at: bottomIndex, at: .bottom, animated: animated)
    }
}
