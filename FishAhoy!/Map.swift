//
//  Map.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Map: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapLife: MKMapView!
    
    let manager = CLLocationManager()
    
    // back button
    @IBAction func backBTM(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func naviagteBTM(_ sender: Any) {
        if let annotation = mapLife.annotations.first {
            
            // navigation with google map
            if let url = URL(string: "http://maps.apple.com/maps?daddr=\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapLife.delegate = self
        mapLife.showsScale = true
        mapLife.showsPointsOfInterest = true
        mapLife.showsUserLocation = true
        
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        
        
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

