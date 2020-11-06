//
//  LoveChatViewController.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 13.10.2020.
//

import UIKit
import MessageKit
import InputBarAccessoryView

enum ChatMessageType {
    case small
    case big
    case sticker
    case selfSmall
    case selfSmallCustom
    case selfSticker(UIImage)
    case selfBig
}

class LoveChatViewController: UIViewController {
  
  @IBOutlet weak var greenText: UILabel!
  @IBOutlet weak var whiteText: UILabel!
  @IBOutlet weak var backImage: UIImageView! {
    didSet {
      backImage.isUserInteractionEnabled = true
      backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnBack)))
    }
  }
  @IBOutlet weak var greenBubble: UIImageView!{
    didSet {
      greenBubble.isUserInteractionEnabled = true
      greenBubble.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseGreenVariant)).then { $0.cancelsTouchesInView = false})
    }
  }
  @IBOutlet weak var whiteBubble: UIImageView!{
    didSet {
      whiteBubble.isUserInteractionEnabled = true
      whiteBubble.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseWhiteVariant)).then { $0.cancelsTouchesInView = false})
    }
  }
  @IBOutlet weak var sendImageButton: UIImageView! {
    didSet {
      sendImageButton.isUserInteractionEnabled = true
      sendImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendMessage)))
    }
  }
  @IBOutlet weak var chatHeader: UIImageView!
  @IBOutlet weak var chatTableView: UITableView! {
    didSet {
      chatTableView.do {
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.register(UINib(nibName: "SmallBubleTableViewCell", bundle: nil), forCellReuseIdentifier: "littleBubbleCell")
        $0.register(UINib(nibName: "BigBubleTableViewCell", bundle: nil), forCellReuseIdentifier: "bigBubbleCell")
        $0.register(UINib(nibName: "StickerTableViewCell", bundle: nil), forCellReuseIdentifier: "stickerBubbleCell")
        $0.register(UINib(nibName: "SelfSmallTableViewCell", bundle: nil), forCellReuseIdentifier: "selfLittleCell")
        $0.register(UINib(nibName: "SelfStickerTableViewCell", bundle: nil), forCellReuseIdentifier: "selfStickerCell")
        $0.backgroundColor = .clear
      }
    }
  }
  @IBOutlet weak var stickerCollectionView: UICollectionView! {
    didSet {
      stickerCollectionView.do {
        $0.delegate = self
        $0.dataSource = self
        $0.register(UINib(nibName: "StickerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sticker")
        $0.backgroundColor = .clear
      }
    }
  }
  let stickers = [UIImage(named: "bananaStiker"),
                  UIImage(named: "bootStiker"),
                  UIImage(named: "busStiker"),
                  UIImage(named: "catStiker"),
                  UIImage(named: "iceStiker"),
                  UIImage(named: "retroStiker"),
                  UIImage(named: "starStiker")]
    var messages:[ChatMessageType] = [.small,.big,.sticker,.selfSmall, .selfBig]
  
  var variant:Bool = false
  
  override func viewDidLoad() {
        super.viewDidLoad()
    chatTableView.contentInset = UIEdgeInsets(top: chatHeader.frame.height - 45, left: 0, bottom: 0, right: 0)
    
  }
  
  @objc func sendMessage() {
    sendImageButton.pulsate()
    self.messages.append(.selfSmallCustom)
    self.chatTableView.beginUpdates()
    self.chatTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .automatic)
    self.chatTableView.endUpdates()
    chatTableView.scrollTableViewToBottom(animated: true)
    
  }
  
  @objc func chooseWhiteVariant() {
    greenBubble.image = UIImage(named: "whiteVarBubble")
    whiteBubble.image = UIImage(named: "greenVarBubble")
    variant = true
  }
  
  @objc func chooseGreenVariant() {
    greenBubble.image = UIImage(named: "greenVarBubble")
    whiteBubble.image = UIImage(named: "whiteVarBubble")
    variant = false
  }
  
  @objc func returnBack() {
    navigationController?.popViewController(animated: true)
  }
}

extension LoveChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.messages.append(.selfSticker(stickers[indexPath.row]!)!)
    self.chatTableView.beginUpdates()
    self.chatTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .automatic)
    self.chatTableView.endUpdates()
    chatTableView.scrollTableViewToBottom(animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return stickers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sticker", for: indexPath) as! StickerCollectionViewCell
    cell.configureCell(stickers[indexPath.row]!)
    return cell
  }
  
  
}


extension LoveChatViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    switch messages[indexPath.row] {
    case .big: return 93
    case .sticker, .selfSticker: return 100
    default: return 36
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return messages.count
    }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    func checkCell() -> UITableViewCell {
        switch messages[indexPath.row] {
        case .small: return tableView.dequeueReusableCell(withIdentifier: "littleBubbleCell", for:  indexPath) as! SmallBubleTableViewCell
        case .big: return tableView.dequeueReusableCell(withIdentifier: "bigBubbleCell", for: indexPath)    as! BigBubleTableViewCell
        case .sticker: return tableView.dequeueReusableCell(withIdentifier: "stickerBubbleCell", for:   indexPath) as! StickerTableViewCell
        case .selfSmall: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for:    indexPath) as! SelfSmallTableViewCell
          cell.configureCell("", isCustom: false)
          return cell
        case .selfSmallCustom: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell",   for: indexPath) as! SelfSmallTableViewCell
          cell.configureCell(variant ? whiteText.text! : greenText.text!, isCustom: true)
          return cell
        case .selfBig:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelfBigBubleTableViewCell", for: indexPath) as! SelfBigBubleTableViewCell
            return cell
        case .selfSticker(let image):
          let cell = tableView.dequeueReusableCell(withIdentifier: "selfStickerCell", for: indexPath) as! SelfStickerTableViewCell
          cell.setImage(image)
          return cell
            
            }
      }
      return checkCell()
    }
}
