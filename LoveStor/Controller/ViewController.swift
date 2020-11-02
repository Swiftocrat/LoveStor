//
//  ViewController.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 09.10.2020.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

    @IBAction func letsGoButtonTapped(_ sender: Any) {
        guard let kolodaVC = storyboard?.instantiateViewController(identifier: "KolodaViewController") as? KolodaViewController else { return }
        show(kolodaVC, sender: self)
    }
}

