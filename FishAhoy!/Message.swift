//
//  Message.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var id: String
    var sender: String?
    var text: String?
    var date = 0.0
    
    // load user text to firebase
    init(snapshot: DataSnapshot) {
        id = snapshot.key
        let enumerator = snapshot.children
        while let child = enumerator.nextObject() as? DataSnapshot {
            if child.key == "text" {
                text = child.value as? String
            }
            else if child.key == "date" {
                if let theDate = child.value as? Double {
                    date = theDate
                }
            }
            else if child.key == "sender" {
                sender = child.value as? String
            }
        }
    }
    
    init(message: String?) {
        id = ""
        sender = Auth.auth().currentUser?.uid
        text = message
        date = Date().timeIntervalSince1970
    }
}
