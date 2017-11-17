//
//  Home.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import SideMenu
import FBSDKLoginKit
import Firebase

class Home: UIViewController {
    
    @IBOutlet weak var displayName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let sideVC = storyboard!.instantiateViewController(withIdentifier: "fishMenu")
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: sideVC)
        
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // let label display user name or username based on their account
        if let userId = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(userId).child("name").observe(.value, with: { (snapshot) in
                self.displayName.text = snapshot.value as? String
            })
        }
    }
    
    
    @IBAction func sideMenuBTM(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

