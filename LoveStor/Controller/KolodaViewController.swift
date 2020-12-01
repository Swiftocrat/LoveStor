//
//  KolodaViewController.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 10.10.2020.
//

import UIKit
import Koloda
import Then

class KolodaViewController: UIViewController {
  
    @IBOutlet weak var likeGradientView:   GradientView!
    @IBOutlet weak var crossGradientView:  GradientView!
    @IBOutlet weak var likeButton: UIView! {
      didSet {
        likeButton.addGestureRecognizer   (UITapGestureRecognizer (target: self, action:  #selector(likeTapped)))
      }
    }
    @IBOutlet weak var crossButton:     UIView! {
      didSet {
        crossButton.addGestureRecognizer   (UITapGestureRecognizer (target: self, action:  #selector(crossTapped)))
      }
    }
  
    let images:[UIImage] = Array(repeating: UIImage(named: "woman")!, count: 3)
  
    @IBOutlet weak var kolodaView:  KolodaView! {
      didSet {
          kolodaView.layer.cornerRadius = 30
        kolodaView.dataSource = self
        kolodaView.delegate = self
        kolodaView.layer.cornerRadius = 30
      }
    }
    override func viewDidAppear(_   animated: Bool) {
      likeGradientView.makeCircle()
      crossGradientView.makeCircle()
      crossButton.do {
        $0.makeCircle()
        $0.dropShadow()
      }
      likeButton.do {
        $0.makeCircle()
        $0.dropShadow()
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @objc func crossTapped() {
        crossButton.pulsate()
    }
    
    @objc func likeTapped() {
        likeButton.pulsate()
    }
    
    @IBAction func userButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserViewController") as! UserViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension KolodaViewController: KolodaViewDelegate, KolodaViewDataSource {
  
  func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "stories")
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    koloda.reloadInputViews()
  }
  
  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    return Bundle.main.loadNibNamed("KolodaCardView", owner: self, options: nil)![0] as! KolodaCardView//UIImageView(image: images[index])
  }
  
  func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
    images.count
  }
  
  func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
    //return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)[0] as? OverlayView
    return UIView().then { $0.backgroundColor = .black } as? OverlayView
  }
  
}

