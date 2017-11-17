//
//  UserContact.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import Firebase

class UserContact: UIViewController {

    var users = [Users]()
    var delegate: UserContactDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        Database.database().reference().child("users").observe(.value, with: { (snapshot) in
            self.users.removeAll()
            let enumerator = snapshot.children
            while let child = enumerator.nextObject() as? DataSnapshot {
                if child.key != Auth.auth().currentUser?.uid {
                    let user = Users(snapshot: child)
                    self.users.append(user)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

// display user name who are avaible in the app
extension UserContact: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        delegate?.usersContact(controller: self, didSelectUser: user)
    }
}

protocol UserContactDelegate{
    func usersContact(controller: UserContact, didSelectUser user: Users)
}

