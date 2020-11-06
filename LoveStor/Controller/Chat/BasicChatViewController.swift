//
//  LoveChatViewController.swift
//  LoveStor
//
//  Created by Yaroslav Vushnyak on 13.10.2020.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class BasicChatViewController: UIViewController {
  
    var responseIndex: IndexPath?
    
    @IBOutlet weak var backImage: UIImageView! {
      didSet {
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnBack)))
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
          $0.register(UINib(nibName: "SmallBubleTableViewCell", bundle: nil), forCellReuseIdentifier:   "littleBubbleCell")
          $0.register(UINib(nibName: "BigBubleTableViewCell", bundle: nil), forCellReuseIdentifier: "bigBubbleCell")
          $0.register(UINib(nibName: "StickerTableViewCell", bundle: nil), forCellReuseIdentifier:  "stickerBubbleCell")
          $0.register(UINib(nibName: "SelfSmallTableViewCell", bundle: nil), forCellReuseIdentifier:    "selfLittleCell")
          $0.register(UINib(nibName: "SelfStickerTableViewCell", bundle: nil), forCellReuseIdentifier:  "selfStickerCell")
          $0.backgroundColor = .clear
        }
      }
    }
    
      @IBOutlet weak var messageTextView: UITextView!
    
    var messages:[ChatMessageType] = [.small, .big, .sticker, .selfSmall]
    var variant: Bool = false
    
    override func viewDidLoad() {
          super.viewDidLoad()
    
      chatTableView.contentInset = UIEdgeInsets(top: chatHeader.frame.height - 45, left: 0, bottom: 0, right: 0)
    }
    
    @objc func sendMessage() {
      sendImageButton.pulsate()
      self.messages.append(.big)
      self.chatTableView.beginUpdates()
      self.chatTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .automatic)
      self.chatTableView.endUpdates()
      chatTableView.scrollTableViewToBottom(animated: true)
    
    }
    
    @objc func returnBack() {
      navigationController?.popViewController(animated: true)
    }
}

extension BasicChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch messages[indexPath.row] {
        case .big: return 126
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
            case .small:
                return tableView.dequeueReusableCell(withIdentifier: "littleBubbleCell", for: indexPath) as! SmallBubleTableViewCell
            case .big:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigBubbleCell", for: indexPath) as! BigBubleTableViewCell
                cell.bubbleTextView.text = messageTextView.text
                let currentIndex = indexPath.row
                if responseIndex?.row == currentIndex - 1 {
                    cell.bubbleImageView.image = UIImage(named: "bigBubbleReversed")
                }
                return cell
            case .sticker:
                print("STICKER")
                return tableView.dequeueReusableCell(withIdentifier: "stickerBubbleCell", for: indexPath) as! StickerTableViewCell
            case .selfSmall: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                responseIndex = indexPath
                print("SelfSmall")
                cell.configureCell("", isCustom: false)
                return cell
            case .selfSmallCustom: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                responseIndex = indexPath
                print("SelfSmallCustom")
                cell.configureCell(messageTextView.text, isCustom: true)
                return cell
            case .selfSticker(let image):
                let cell = tableView.dequeueReusableCell(withIdentifier: "selfStickerCell", for: indexPath) as! SelfStickerTableViewCell
                responseIndex = indexPath
                cell.setImage(image)
                return cell
            }
        }
        return checkCell()
    }
}
