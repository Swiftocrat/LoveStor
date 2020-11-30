//
//  AvatarSelectionViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 26.11.2020.
//

import UIKit

class AvatarSelectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    let iconsArray = [UIImage(named: "avatar1"), UIImage(named: "avatar2"), UIImage(named: "avatar3"), UIImage(named: "avatar4"), UIImage(named: "avatar5"), UIImage(named: "avatar6"), UIImage(named: "avatar7"), UIImage(named: "avatar8"), UIImage(named: "avatar9"), UIImage(named: "avatar10"), UIImage(named: "avatar11"), UIImage(named: "avatar12")]
    let iconsNamesArray = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5", "avatar6",  "avatar7", "avatar8", "avatar9", "avatar10", "avatar11", "avatar12"]
    var selectedIndex: Int?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "ProfileIconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "profileIconCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        if UIScreen.main.bounds.height < 668.0 {
            collectionViewHeightConstraint.constant = 439.0
            let cellSize = (collectionView.frame.width/3)-25
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 15
            layout.itemSize = CGSize(width: cellSize, height: cellSize)
        } else {
            layout.minimumInteritemSpacing = 20
            layout.minimumLineSpacing = 20
            layout.itemSize = CGSize(width: 110, height: 110)
        }
        
//        if UIScreen.main.bounds.height > 667.0 {
//
//        }
        collectionView.collectionViewLayout = layout
//        collectionView.collectionViewLayout = setupLayout()
    }
    
//    func setupLayout() -> UICollectionViewCompositionalLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.3))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80.0))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//
//        return UICollectionViewCompositionalLayout(section: section)
//    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let selectedIndex = selectedIndex else { return }
        defaults.setValue(iconsNamesArray[selectedIndex], forKey: "selectedIcon")
    }
}

extension AvatarSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileIconCell", for: indexPath) as! ProfileIconCollectionViewCell
        cell.avatarImageView.image = iconsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}
