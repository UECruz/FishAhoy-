//
//  Tutorial.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/15/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import SideMenu

class Tutorial: UITableViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 4
    }
    
    @IBAction func traning1_BTN(_ sender: Any) {
        if let url = NSURL(string: "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=video&cd=1&cad=rja&uact=8&ved=0ahUKEwjym6zQ8dXWAhUCRSYKHcRwBF8QtwIIKDAA&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DKeRgkiWTRT4&usg=AOvVaw2omTwJY4_k58ZZLY-UKZBf"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func traning2_BTN(_ sender: Any) {
        if let url = NSURL(string: "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=video&cd=3&cad=rja&uact=8&ved=0ahUKEwjym6zQ8dXWAhUCRSYKHcRwBF8QtwIINDAC&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DdTG1alSVcyo&usg=AOvVaw1LgUbXSXa3jC4-rCv1yV18"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func traning3_BTN(_ sender: Any) {
        if let url = NSURL(string: "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=video&cd=9&cad=rja&uact=8&ved=0ahUKEwjym6zQ8dXWAhUCRSYKHcRwBF8QtwIITzAI&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3D0TPWJGnrjyA&usg=AOvVaw3QVCpgoLGXKENiHUFRk0pr"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    @IBAction func traning4_BTN(_ sender: Any) {
        if let url = NSURL(string: "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=video&cd=18&cad=rja&uact=8&ved=0ahUKEwjDnIKn89XWAhWCJCYKHamRB4w4ChC3AghIMAc&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DJvf0ZHkt3C8&usg=AOvVaw2tiEy_1DYDqFPmlZeEJa7Y"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }

}
