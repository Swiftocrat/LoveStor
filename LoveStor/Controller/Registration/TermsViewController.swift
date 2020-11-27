//
//  TermsViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 26.11.2020.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var conditionsTextView: UITextView!
    
    var titleText = ""
    var conditionsText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setText()
    }
    
    func setText() {
        titleLabel.text = titleText
        conditionsTextView.text = conditionsText
    }
}
