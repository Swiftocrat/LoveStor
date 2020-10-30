//
//  KolodaView.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 30.10.2020.
//

import UIKit

class KolodaCardView: UIView {

  @IBOutlet var contentView:UIView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("KolodaView", owner: self, options: nil)
    addSubview(contentView)
    contentView.do {
      $0.frame = self.bounds
      $0.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
  }

}
