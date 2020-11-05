//
//  ChatVC.swift
//  LoveStor
//
//  Created by ****** ****** on 03.11.2020.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var backButtonImageView: UIImageView! {
        didSet {
            backButtonImageView.isUserInteractionEnabled = true
            backButtonImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnBack)))
        }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func returnBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
