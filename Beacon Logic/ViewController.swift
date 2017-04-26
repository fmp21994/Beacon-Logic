//
//  ViewController.swift
//  Estimote Tutorial
//
//  Created by Frankie Palmisano on 3/15/17.
//  Copyright © 2017 Frankie Palmisano. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, ESTBeaconManagerDelegate  {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var audioPlayer = AVAudioPlayer()
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
        identifier: "ranged region")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        self.beaconManager.startRangingBeacons(in: self.beaconRegion)
        self.activityIndicator.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let closest = beacons.first {
            
            let minor = (closest.minor) as! Int
            
            if (closest.proximity.rawValue == 1) {
                self.activityIndicator?.stopAnimating()
                self.activityIndicator?.isHidden = true
                switch minor {
                case 42553:
                    
                    self.view.backgroundColor = UIColor.purple
                    self.label.text = "This is a water bottle!"
                    self.image.isHidden = false
                    print("Purple");
                    var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource)
                    
                    
                case 10335:
                    
                    self.view.backgroundColor = UIColor.green
                    self.label.text = "This is a chair!"
                    self.image.isHidden = false
                    print("Mint");
                    
                case 53328:
                    
                    self.view.backgroundColor = UIColor.blue
                    self.label.text = "This is a purse!"
                    self.image.isHidden = false
                    print("ice");
                    
                default:
                    
                    self.view.backgroundColor = UIColor.lightGray
                    self.label.text = "You are not immediately close to an object (within 1m)."
                    self.image.isHidden = true
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.isHidden = false
                    print("error?")
                    break;
                    
                }
                
            } else {
                
                self.view.backgroundColor = UIColor.lightGray
                self.label.text = "You are not immediately close to an object (within 1m)."
                self.image.isHidden = true
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
                print("None in range")
                
            }
        }
    }
}

