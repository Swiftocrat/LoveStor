//
//  PaidAnswerChatViewController.swift
//  LoveStor
//
//  Created by ***** ****** on 13.10.2020.
//

import UIKit
import InputBarAccessoryView

class PaidAnswerChatViewController: UIViewController {
    
    enum PaidChatMessageType {
        case small
        case big
        case sticker
        case selfSmall
        case selfSmallCustom
        case selfSticker(UIImage)
        case selfBig
        case selfPaidSmall
        case selfPaidSmallCustom
        case smallReaction
//        case selfPaidBig
    }
    
    var tutorialIsOver: Bool = false
    
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
                $0.register(UINib(nibName: "SmallWithReactionCell", bundle: nil),   forCellReuseIdentifier: "smallBubbleWithReactionCell")
                $0.backgroundColor = .clear
            }
          }
        }
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var paidMessageTextView: UITextView!
    @IBOutlet weak var likePopupView: UIView!
    @IBOutlet weak var backgroundShadowView: UIView!
    @IBOutlet weak var insetShadowView: UIView!
    @IBOutlet weak var fingerImageView: UIImageView!
    
    var showingReactionButton = true
    var tableViewBackgroundShadowView: UIView?
    var responseIndex: IndexPath?
    var messages: [PaidChatMessageType] = [.small, .big, .sticker, .big, .selfPaidSmall, .smallReaction]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        chatTableView.isScrollEnabled = false
        insetShadowView.backgroundColor = .black
        likePopupView.layer.opacity = 0.6
        likePopupView.layer.opacity = 0
        likePopupView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePopup)))
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            let index = IndexPath(row: self.messages.count-1, section: 0)
            self.chatTableView.scrollToRow(at: index, at: .bottom, animated: false)
        }
    }
    
    @IBAction func sendPaidMessageButtonTapped(_ sender: Any) {
        sendPaidMessage()
    }
    
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        sendMessage()
    }
    
    @objc func sendMessage() {
//      sendImageButton.pulsate()
      self.messages.append(.selfSmallCustom)
      self.chatTableView.beginUpdates()
      self.chatTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .automatic)
      self.chatTableView.endUpdates()
      chatTableView.scrollTableViewToBottom(animated: true)
    }
    
    @objc func sendPaidMessage() {
        self.messages.append(.selfPaidSmallCustom)
        self.chatTableView.beginUpdates()
        self.chatTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .automatic)
        self.chatTableView.endUpdates()
        chatTableView.scrollTableViewToBottom(animated: true)
    }
    
    @objc func sendMessageWithReaction() {
        self.messages.append(.smallReaction)
        self.chatTableView.beginUpdates()
        self.chatTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)],   with: .automatic)
        self.chatTableView.endUpdates()
        chatTableView.scrollTableViewToBottom(animated: true)
    }
    
    @objc func returnBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func hidePopup() {
        UIView.animate(withDuration: 0.2) {
            self.likePopupView.layer.opacity = 0
        }
        hideBackgroundShadow()
    }
}

extension PaidAnswerChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch messages[indexPath.row] {
        case .big, .selfBig: return 126
        case .sticker, .selfSticker: return 100
        case .smallReaction: return 71
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
//                cell.configureCell(showsReactionButton: showingReactionButton)
                cell.configureShadow(removeShadow: tutorialIsOver)
                return cell
            case .big:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigBubbleCell", for: indexPath) as! BigBubleTableViewCell
                responseIndex = indexPath
                cell.configureShadow(removeShadow: tutorialIsOver)
                return cell
            case .sticker:
                let cell = tableView.dequeueReusableCell(withIdentifier: "stickerBubbleCell", for: indexPath) as! StickerTableViewCell
                print("STICKER")
                responseIndex = indexPath
                cell.configureShadow(removeShadow: tutorialIsOver)
                return cell
                //MARK: --SELF
            case .selfSmall: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                print("selfBubble")
                cell.configureCell("", isCustom: false)
                let currentIndex = indexPath.row
                cell.configureShadow(removeShadow: tutorialIsOver)
                if responseIndex?.row == currentIndex - 1 {
                    cell.longBubble.image = UIImage(named: "selfBubbleReversed")
                }
                return cell
            case .selfSmallCustom: let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                print("SelfSmallCustom")
                cell.configureCell(messageTextView.text, isCustom: true)
                cell.longBubble.image = UIImage(named: "selfLong")
                cell.longLabel.text = messageTextView.text
                let currentIndex = indexPath.row
                cell.configureShadow(removeShadow: tutorialIsOver)
                if responseIndex?.row == currentIndex - 1 {
                    cell.longBubble.image = UIImage(named: "selfLongBubbleReversed")
                }
                return cell
            case .selfBig: let cell = tableView.dequeueReusableCell(withIdentifier: "selfBigBubbleCell", for: indexPath) as! SelfBigBubleTableViewCell
                cell.bubbleTextView.text = messageTextView.text
                let currentIndex = indexPath.row
                cell.configureShadow(removeShadow: tutorialIsOver)
                if responseIndex?.row == currentIndex - 1 {
                    cell.bubbleImageView.image = UIImage(named: "RectanglePinkReversed")
                }
                return cell
            case .selfSticker(let image):
                let cell = tableView.dequeueReusableCell(withIdentifier: "selfStickerCell", for: indexPath) as! SelfStickerTableViewCell
                cell.setImage(image)
                cell.configureShadow(removeShadow: tutorialIsOver)
                return cell
            //MARK: --Paid
            case .selfPaidSmall:
                let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as!  SelfSmallTableViewCell
                print("SelfPaidSmall")
                cell.shortBubble.image = UIImage(named: "selfGreenBubble")
                cell.configureCell("", isCustom: false)
                cell.configureShadow(removeShadow: tutorialIsOver)
                return cell
            case .selfPaidSmallCustom:
                let cell = tableView.dequeueReusableCell(withIdentifier: "selfLittleCell", for: indexPath) as! SelfSmallTableViewCell
                print("SelfSmallCustom")
                cell.configureCell(paidMessageTextView.text, isCustom: true)
                cell.longBubble.image = UIImage(named: "selfGreenBubbleLong")
                let currentIndex = indexPath.row
                cell.configureShadow(removeShadow: tutorialIsOver)
                if responseIndex?.row == currentIndex - 1 {
                    cell.longBubble.image = UIImage(named: "selfGreenBubbleLongReversed")
                }
                return cell
            case .smallReaction:
                responseIndex = indexPath
                let cell = tableView.dequeueReusableCell(withIdentifier: "smallBubbleWithReactionCell", for: indexPath) as! SmallWithReactionCell
                cell.delegate = self
                if !tutorialIsOver {
                    backgroundShadowView.backgroundColor = .black
                    backgroundShadowView.layer.opacity = 0.6
                }
                cell.removeShadowClosure = {
                    UIView.animate(withDuration: 0.2) {
                        cell.backgroundShadowView.layer.opacity = 0
                        self.insetShadowView.layer.opacity = 0
                        self.fingerImageView.layer.opacity = 0
                        self.chatTableView.isScrollEnabled = true
                    }
                    self.tutorialIsOver = true
                    tableView.reloadData()
                }
                return cell
            }
        }
        return checkCell()
    }
}

extension PaidAnswerChatViewController: ReactionDelegate {
    func showPopup() {
        UIView.animate(withDuration: 0.2) {
            self.likePopupView.layer.opacity = 1
            
        }
    }
    
    func hideBackgroundShadow() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundShadowView.layer.opacity = 0
            self.tableViewBackgroundShadowView?.layer.opacity = 0
            self.insetShadowView.layer.opacity = 0
        }
    }
}
