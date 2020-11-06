//
//  PaidAnswerChatViewController.swift
//  LoveStor
//
//  Created by ***** ****** on 13.10.2020.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class PaidAnswerChatViewController: UIViewController {
    
    @IBOutlet weak var sendPaidMessageButton: UIImageView!
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
              $0.register(UINib(nibName: "StickerTableViewCell", bundle: nil), forCellReuseIdentifier:  "stickerBubbleCell")
              $0.register(UINib(nibName: "SelfSmallTableViewCell", bundle: nil),    forCellReuseIdentifier: "selfLittleCell")
              $0.register(UINib(nibName: "SelfStickerTableViewCell", bundle:    nil), forCellReuseIdentifier: "selfStickerCell")
                $0.register(UINib(nibName: "SelfBigBubbleTableViewCell", bundle: nil), forCellReuseIdentifier: "selfBigBubbleCell")
              $0.backgroundColor = .clear
            }
          }
        }
    
      @IBOutlet weak var messageTextView: UITextView!
    
    var responseIndex: IndexPath?
    var messages: [ChatMessageType] = [.small, .big, .sticker, .selfSmall, .big, .small]
    
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
    
    @objc func returnBack() {
      navigationController?.popViewController(animated: true)
    }
}

extension PaidAnswerChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch messages[indexPath.row] {
        case .big, .selfBig: return 126
        case .sticker, .selfSticker: return 100
        default: return 55
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
                return tableView.dequeueReusableCell(withIdentifier: "littleBubbleCell", for: indexPath) as! SmallBubleTableViewCell
            case .big:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigBubbleCell", for: indexPath) as! BigBubleTableViewCell
                responseIndex = indexPath
                return cell
            case .sticker:
                print("STICKER")
                responseIndex = indexPath
                return tableView.dequeueReusableCell(withIdentifier: "stickerBubbleCell", for: indexPath) as! StickerTableViewCell
                
                //MARK: --SELF
            case .selfSmall: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                print("SelfSmall")
                cell.configureCell("", isCustom: false)
                return cell
            case .selfSmallCustom: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                print("SelfSmallCustom")
                cell.configureCell(messageTextView.text, isCustom: true)
                return cell
            case .selfBig: let cell = tableView.dequeueReusableCell(withIdentifier: "selfBigBubbleCell", for: indexPath) as! SelfBigBubleTableViewCell
                cell.bubbleTextView.text = messageTextView.text
                let currentIndex = indexPath.row
                if responseIndex?.row == currentIndex - 1 {
                    cell.bubbleImageView.image = UIImage(named: "RectanglePinkReversed")
                }
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
