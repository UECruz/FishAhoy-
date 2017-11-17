//
//  Reference.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import MapKit

class Reference: UIViewController {
    
    @IBOutlet var locationsBTm: [UIButton]!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var dates: UILabel!
    @IBOutlet weak var specie: UILabel!
    @IBOutlet weak var scienticName: UILabel!
    
    var lib: [String : Any]?
    var specificId: String?
    var info: [String : Any]?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // showing the information of that fish
        self.name.text = info?["commonName"] as? String
        self.group.text = info?["family"] as? String
        self.type.text = info?["freshMarineIntro"] as? String
        self.scienticName.text = info?["scientificName"] as? String
        self.specie.text = info?["species"] as? String
        self.dates.text = info?["date"] as? String
        self.locationsBTm[0].setTitle(info?["locality"] as? String, for: .normal)
        
        if let maps =  UserDefaults.standard.array(forKey: "map") as? [[String : String]] {
            locationsBTm[0].isSelected = maps.contains(where: {$0["locality"] == specificId})
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    // Clicking on the location let u go to the location
    @IBAction func placeToGO(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Maps") as? Map {
            let latitude: CLLocationDegrees = (info?["decimalLatitude"] as? Double)!
            let longtitude : CLLocationDegrees = (info?["decimalLongitude"] as? Double)!
            let span : MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let coordinate = CLLocationCoordinate2DMake(latitude,longtitude)
            let region : MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = info?["locality"] as? String
            annotation.subtitle = info?["state"] as? String
            
            self.present(vc, animated: true, completion: {
                DispatchQueue.main.async {
                    vc.mapLife.setRegion(region, animated: true)
                    vc.mapLife.addAnnotation(annotation)
                    
                }
            })
        }
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

