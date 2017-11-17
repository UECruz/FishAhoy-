//
//  Shop.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/15/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import SideMenu

class Shop: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    
    @IBAction func poleBtn(_ sender: Any) {
        if let url = NSURL(string: "https://www.amazon.com/s/ref=nb_sb_ss_c_1_12?url=search-alias%3Daps&field-keywords=fishing+pole&sprefix=fishing+pole%2Caps%2C192&crid=XLA5VBT2DSGD"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func bait_Btn(_ sender: Any) {
        if let url = NSURL(string: "https://www.amazon.com/s/ref=nb_sb_ss_c_1_12?url=search-alias%3Daps&field-keywords=fishing+bait&sprefix=fishing+bait%2Caps%2C158&crid=3V49Q7JGBNVGZ&rh=i%3Aaps%2Ck%3Afishing+bait"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func hook_btn(_ sender: Any) {
        if let url = NSURL(string: "https://www.amazon.com/s/ref=nb_sb_ss_c_1_9?url=search-alias%3Daps&field-keywords=fishing+hooks&sprefix=fishing+h%2Caps%2C167&crid=1QSRU14LZPCXN&rh=i%3Aaps%2Ck%3Afishing+hooks"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func tool_BTN(_ sender: Any) {
        if let url = NSURL(string: "https://www.amazon.com/s/ref=nb_sb_ss_c_1_12?url=search-alias%3Daps&field-keywords=fishing+tools&sprefix=fishing+tool%2Caps%2C159&crid=2BKU6T2JZRWEM&rh=i%3Aaps%2Ck%3Afishing+tools"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    @IBAction func line_BTN(_ sender: Any) {
        if let url = NSURL(string: "https://www.amazon.com/s/ref=nb_sb_ss_c_1_11?url=search-alias%3Daps&field-keywords=fishing+line&sprefix=fishing+lin%2Caps%2C164&crid=IZU4ZW39WZWI&rh=i%3Aaps%2Ck%3Afishing+line"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    @IBAction func reel_BTN(_ sender: Any) {
        if let url = NSURL(string: "https://www.amazon.com/s/ref=nb_sb_ss_c_1_11?url=search-alias%3Daps&field-keywords=fishing+reel&sprefix=fishing+res%2Caps%2C178&crid=2UVPCYFL8Q54H&rh=i%3Aaps%2Ck%3Afishing+reel"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func fish_clothingBtn(_ sender: Any) {
        if let url = NSURL(string: "https://www.amazon.com/s/ref=nb_sb_ss_i_6_12?url=search-alias%3Daps&field-keywords=fishing+clothing&sprefix=fishing+clot%2Caps%2C163&crid=3C0U5IC3RYOPS&rh=i%3Aaps%2Ck%3Afishing+clothing"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    


}
