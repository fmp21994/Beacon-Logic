//
//  ViewController.swift
//  Beacon Logic
//
//  Created by Frank Palmisano on 3/15/17.
//  Copyright © 2017 Frank Palmisano. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, ESTBeaconManagerDelegate  {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var audioPlayer = AVAudioPlayer()
    var go = true
    var once = true
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
        identifier: "ranged region")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Hi I'm Life Jewel", ofType: "m4a")!))
//            audioPlayer.prepareToPlay()
//            audioPlayer.play()
        } catch {
            print(error)
        }
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
        if go == true {
        if let closest = beacons.first {
            let minor = (closest.minor) as! Int
            
            
                if (closest.proximity.rawValue == 1) {
                    self.activityIndicator?.stopAnimating()
                    self.activityIndicator?.isHidden = true
                    switch minor {
                        
                    case 42553:
                        self.view.backgroundColor = UIColor.purple
                        self.label.text = "This is a Television!"
                        self.image.isHidden = false
                        print("Purple")
                        playSoundEffect(minor: minor)
                        go = false
                        pause()
                        
                    case 10335:
                        self.view.backgroundColor = UIColor.green
                        self.label.text = "This is a Couch!"
                        self.image.isHidden = false
                        print("Mint")
                        if once == true {
                            playSoundEffect(minor: minor)
                            go = false
                            once = false
                            pause()
                        }
                       
                        
                    case 53328:
                        self.view.backgroundColor = UIColor.blue
                        self.label.text = "This is a Refrigerator!"
                        self.image.isHidden = false
                        print("ice");
                        playSoundEffect(minor: minor)
                        go = false
                        pause()
                        
                    default:
                        self.view.backgroundColor = UIColor.lightGray
                        self.label.text = "You are not immediately close to an object (within 1m)."
                        self.image.isHidden = true
                        self.activityIndicator.startAnimating()
                        self.activityIndicator.isHidden = false
                        print("error?")
                        
                    }
                }
            }
        }
    }
    
    func playSoundEffect(minor: Int) {
        switch minor {
        case 42553:
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Television", ofType: "m4a")!))
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }

        case 10335:
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Couch", ofType: "m4a")!))
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
            
        case 53328:
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "FRIDGE", ofType: "m4a")!))
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
            
        default:
            print("nothing was played")
        }
    }
    
    func pause() {
        let deadlineTime = DispatchTime.now() + .seconds(6)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.go = true
        }
    }
}

