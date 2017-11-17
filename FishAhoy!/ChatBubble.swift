//
//  ChatBubble.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import Firebase

class ChatBubble: NSObject {
    
    var id: String
    var user: String?
    var lastMessage: String?
    var lastMessageDate = 0.0
    
    // load the data from last text from sender
    init(snapshot: DataSnapshot) {
        id = snapshot.key
        let enumerator = snapshot.children
        while let child = enumerator.nextObject() as? DataSnapshot {
            if child.key != Auth.auth().currentUser?.uid {
                
                if child.key == "lastMessage" {
                    lastMessage = child.value as? String
                }
                else if child.key == "lastMessageDate" {
                    if let theDate = child.value as? Double {
                        lastMessageDate = theDate
                    }
                }
                else {
                    user = child.value as? String
                }
            }
        }
    }
    
}

