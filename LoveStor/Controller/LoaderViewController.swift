//
//  LoaderViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 03.11.2020.
//

import UIKit

class LoaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let selectionVC = self.storyboard?.instantiateViewController(identifier: "SelectionViewController") as? SelectionViewController else { return }
            self.navigationController?.pushViewController(selectionVC, animated: true)
        }
    }
    
}
