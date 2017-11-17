//
//  Chatroom.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import Firebase

class ChatRoom: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var chatRooms = [ChatBubble]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    @IBAction func backBTM(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    // load data
    func loadData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("chatRooms").observe(.value, with: { (snapshot) in
            self.chatRooms.removeAll()
            let enumerator = snapshot.children
            while let child = enumerator.nextObject() as? DataSnapshot {
                if child.hasChild(userId) {
                    let chatRoom = ChatBubble(snapshot: child)
                    self.chatRooms.append(chatRoom)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    // click on button to see who avaible to chat
    @IBAction func newMessageButtonPressed(_ sender: UIBarButtonItem) {
        if let usersVC = storyboard?.instantiateViewController(withIdentifier: "UsersVC") as? UserContact {
            usersVC.delegate = self
            let userNavigation = UINavigationController(rootViewController: usersVC)
            present(userNavigation, animated: true, completion: nil)
        }
    }
    
}

extension ChatRoom: UserContactDelegate{
    func usersContact(controller: UserContact, didSelectUser user: Users) {
        controller.dismiss(animated: true) {
            if let conversationVC = self.storyboard?.instantiateViewController(withIdentifier: "ConversationVC") as? Conversion {
                conversationVC.user = user
                self.navigationController?.pushViewController(conversationVC, animated: true)
            }
        }
    }
}

// create chatroom private
extension ChatRoom: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomCell", for: indexPath) as! ChatRoomCell
        let chatRoom = chatRooms[indexPath.row]
        cell.senderLabel.text = chatRoom.user
        cell.messageLabel.text = chatRoom.lastMessage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoom = chatRooms[indexPath.row]
        if let conversationVC = self.storyboard?.instantiateViewController(withIdentifier: "ConversionVC") as? Conversion {
            conversationVC.chatRoom = chatRoom
            self.navigationController?.pushViewController(conversationVC, animated: true)
        }
    }
}
