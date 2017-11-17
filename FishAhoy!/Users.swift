//
//  Users.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import Firebase

class Users: NSObject {
    
    var name: String?
    var email: String?
    var id: String
    
    //load user information
    init(snapshot: DataSnapshot) {
        id = snapshot.key
        let enumerator = snapshot.children
        while let child = enumerator.nextObject() as? DataSnapshot {
            if child.key == "name" {
                name = child.value as? String
            }
            else if child.key == "email" {
                email = child.value as? String
            }
        }
    }
    
}

