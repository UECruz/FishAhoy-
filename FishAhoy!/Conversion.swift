//
//  Conversion.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import Firebase

class Conversion: UIViewController {
    
    var chatRoom: ChatBubble?
    var messages = [Message]()
    var user: Users?
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var typeViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        title = chatRoom?.user
        setupViewResizerOnKeyboardShown()
    }
    
    // load the data
    func loadData() {
        guard let theChatRoom = chatRoom else {
            return
        }
        Database.database().reference().child("messages").child(theChatRoom.id).observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            self.messages.removeAll()
            while let child = enumerator.nextObject() as? DataSnapshot {
                let message = Message(snapshot: child)
                self.messages.append(message)
            }
            self.messages.sort(by: {$0.date < $1.date})
            DispatchQueue.main.async {
                self.reloadTableView()
            }
        })
    }
    
    // send message 
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        // Refresh locally
        let newMessage = Message(message: chatTextField.text)
        self.messages.append(newMessage)
        reloadTableView()
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        guard let text = chatTextField.text else {
            return
        }
        
        // save user information to firebse
        if let theChatRoom = chatRoom {
            let messageDic: [String : Any] = ["sender" : userId, "date" : Date().timeIntervalSince1970, "text" : text]
            let chatRoomInfo: [String : Any] = ["lastMessage" : text, "lastMessageDate" : Date().timeIntervalSince1970]
            Database.database().reference().child("messages").child(theChatRoom.id).childByAutoId().setValue(messageDic)
            Database.database().reference().child("chatRooms").child(theChatRoom.id).updateChildValues(chatRoomInfo)
            
        }
        else if let theUser = user {
            let chatRoomInfo: [String : Any] = [theUser.id : theUser.name ?? "", userId : Auth.auth().currentUser?.displayName ?? "", "lastMessage" : text, "lastMessageDate" : Date().timeIntervalSince1970]
            Database.database().reference().child("chatRooms").childByAutoId().setValue(chatRoomInfo, withCompletionBlock: { (error, reference) in
                let messageDic: [String : Any] = ["sender" : userId, "date" : Date().timeIntervalSince1970, "text" : text]
                Database.database().reference().child("messages").child(reference.key).childByAutoId().setValue(messageDic)
            })
        }
        
    }
    
    func reloadTableView() {
        tableView.reloadData()
        let lastIndexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowForResizing),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideForResizing),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    // keyboard will hide when chatroom are private
    @objc func keyboardWillShowForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //  Mininze the keyboard height from the view height because
            // the view could already have been resized for the keyboard before
            typeViewBottomConstraint.constant = keyboardSize.height
        } else {
            debugPrint("The keyboard size or window is either nil: panic widely.")
        }
    }
    
    @objc func keyboardWillHideForResizing(notification: Notification) {
        typeViewBottomConstraint.constant = 0
    }
    
    
    
    
}

extension Conversion: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.sender == Auth.auth().currentUser?.uid {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as! ConversionCell
            cell.messageLabel.text = message.text
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as! ConversionCell
        cell.messageLabel.text = message.text
        return cell
    }
}
