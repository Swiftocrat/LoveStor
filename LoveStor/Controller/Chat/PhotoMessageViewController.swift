//
//  PhotoMessageViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 11.11.2020.
//

import UIKit

class PhotoMessageViewController: UIViewController {
    
    enum ChatMessageTypeWithPhoto {
        case small
        case big
        case sticker
        case selfSmall
        case selfSmallCustom
        case selfSticker(UIImage)
        case selfBig
        case photo
    }
    
    enum PressedButton {
        case first
        case second
    }
    
    var pressedButton: PressedButton = .first
    
    @IBOutlet weak var chatHeader: UIImageView!
    @IBOutlet weak var chatTableView: UITableView! {
        didSet {
            chatTableView.do {
                $0.allowsSelection = false
                $0.separatorStyle = .none
                $0.delegate = self
                $0.dataSource = self
                $0.register(UINib(nibName: "SmallBubleTableViewCell", bundle: nil),   forCellReuseIdentifier: "littleBubbleCell")
                $0.register(UINib(nibName: "BigBubleTableViewCell", bundle: nil), forCellReuseIdentifier:   "bigBubbleCell")
                $0.register(UINib(nibName: "StickerTableViewCell", bundle: nil), forCellReuseIdentifier:    "stickerBubbleCell")
                $0.register(UINib(nibName: "SelfSmallTableViewCell", bundle: nil),      forCellReuseIdentifier: "selfLittleCell")
                $0.register(UINib(nibName: "SelfStickerTableViewCell", bundle: nil),   forCellReuseIdentifier: "selfStickerCell")
                $0.register(UINib(nibName: "SelfBigBubbleTableViewCell", bundle: nil),   forCellReuseIdentifier: "selfBigBubbleCell")
                $0.register(UINib(nibName: "PhotoTableViewCell", bundle: nil),   forCellReuseIdentifier: "photoCell")
                $0.backgroundColor = .clear
            }
          }
        }
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var secondMessageTextView: UITextView!
    
    var responseIndex: IndexPath?
    var messages: [ChatMessageTypeWithPhoto] = [.small, .big, .sticker, .big, .photo]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            let index = IndexPath(row: self.messages.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: index, at: .bottom, animated: false)
        }
    }
    
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        sendMessage()
    }
    
    @IBAction func sendSecondMessageButtonTapped(_ sender: Any) {
        sendSecondMessage()
    }
    
    @objc func sendMessage() {
        
//      sendImageButton.pulsate()
        pressedButton = .first
      self.messages.append(.selfSmallCustom)
      self.chatTableView.beginUpdates()
      self.chatTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .automatic)
      self.chatTableView.endUpdates()
      chatTableView.scrollTableViewToBottom(animated: true)
    }
    
    @objc func sendSecondMessage() {
        pressedButton = .second
      self.messages.append(.selfSmallCustom)
      self.chatTableView.beginUpdates()
      self.chatTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .automatic)
      self.chatTableView.endUpdates()
      chatTableView.scrollTableViewToBottom(animated: true)
    }
    
    @objc func returnBack() {
      navigationController?.popViewController(animated: true)
    }
}

extension PhotoMessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch messages[indexPath.row] {
        case .big, .selfBig: return 126
        case .sticker, .selfSticker: return 100
        case .photo: return 305
        default: return 50
        }
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func checkCell() -> UITableViewCell {
            switch messages[indexPath.row] {
            case .small:
                responseIndex = indexPath
                let cell = tableView.dequeueReusableCell(withIdentifier: "littleBubbleCell", for: indexPath) as! SmallBubleTableViewCell
                cell.configureShadow(removeShadow: true)
//                cell.configureCell(showsReactionButton: showingReactionButton)
                return cell
            case .big:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigBubbleCell", for: indexPath) as! BigBubleTableViewCell
                cell.configureShadow(removeShadow: true)
                responseIndex = indexPath
                return cell
            case .sticker:
                let cell = tableView.dequeueReusableCell(withIdentifier: "stickerBubbleCell", for: indexPath) as! StickerTableViewCell
                cell.configureShadow(removeShadow: true)
                print("STICKER")
                responseIndex = indexPath
                return cell
                //MARK: --SELF
            case .selfSmall: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                print("selfBubble")
                cell.configureCell("", isCustom: false)
                cell.configureShadow(removeShadow: true)
                let currentIndex = indexPath.row
                if responseIndex?.row == currentIndex - 1 {
                    cell.longBubble.image = UIImage(named: "selfBubbleReversed")
                }
                return cell
            case .selfSmallCustom: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                print("SelfSmallCustom")
                cell.configureCell(messageTextView.text, isCustom: true)
                cell.configureShadow(removeShadow: true)
                cell.longBubble.image = UIImage(named: "selfLong")
                if pressedButton == .first {
                    cell.longLabel.text = messageTextView.text
                } else {
                    cell.longLabel.text = secondMessageTextView.text
                }
                let currentIndex = indexPath.row
                if responseIndex?.row == currentIndex - 1 {
                    cell.longBubble.image = UIImage(named: "selfLongBubbleReversed")
                }
                return cell
            case .selfBig: let cell = tableView.dequeueReusableCell(withIdentifier: "selfBigBubbleCell", for: indexPath) as! SelfBigBubleTableViewCell
                cell.bubbleTextView.text = messageTextView.text
                cell.configureShadow(removeShadow: true)
                let currentIndex = indexPath.row
                if responseIndex?.row == currentIndex - 1 {
                    cell.bubbleImageView.image = UIImage(named: "RectanglePinkReversed")
                }
                return cell
            case .selfSticker(let image):
                let cell = tableView.dequeueReusableCell(withIdentifier: "selfStickerCell", for: indexPath) as! SelfStickerTableViewCell
                cell.configureShadow(removeShadow: true)
                cell.setImage(image)
                return cell
            case .photo:
                let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
                cell.configureShadow(removeShadow: true)
                responseIndex = indexPath
                return cell
            }
        }
        return checkCell()
    }
}
