//
//  EntryPopupView.swift
//  LoveStor
//
//  Created by ****** ****** on 25.11.2020.
//

import UIKit

class EntryPopupView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var termsOfServiceButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    
    private let xibName = "EntryPopupView"
    var termsOfServiceAttributedString = NSMutableAttributedString(string: "")
    var privacyPolicyAttributedString = NSMutableAttributedString(string: "")
    let attributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 14),
          .foregroundColor: UIColor.blue,
          .underlineStyle: NSUnderlineStyle.single.rawValue]
    weak var delegate: EntryPopupViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    override func awakeFromNib() {
        setupButtonTitles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setupButtonTitles() {
        let termsOfServiceTitle = NSMutableAttributedString(string:"Terms Of Service", attributes: attributes)
        let privacyPolicyTitle = NSMutableAttributedString(string:"Privacy Policy", attributes: attributes)
        termsOfServiceAttributedString.append(termsOfServiceTitle)
        privacyPolicyAttributedString.append(privacyPolicyTitle)
        termsOfServiceButton.setAttributedTitle(termsOfServiceAttributedString, for: .normal)
        privacyPolicyButton.setAttributedTitle(privacyPolicyAttributedString, for: .normal)
    }
    
    @IBAction func termsOfServiceButtonTapped(_ sender: Any) {
        delegate?.pushTermsViewController(conditionsType: .termsOfCervice)
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: Any) {
        delegate?.pushTermsViewController(conditionsType: .privacyPolicy)
    }
    
    @IBAction func agreeButtonTapped(_ sender: Any) {
        delegate?.pushNameViewController()
    }
}
