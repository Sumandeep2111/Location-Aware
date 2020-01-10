//
//  ViewController.swift
//  Location Aware
//
//  Created by MacStudent on 2020-01-09.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var longLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var altLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        latLabel.text = String(location.coordinate.latitude)
        longLabel.text = String(location.coordinate.longitude)
        speedLabel.text = String(location.speed)
        courseLabel.text = String(location.course)
        altLabel.text = String(location.altitude)
   
        CLGeocoder().reverseGeocodeLocation(location){
                (Placemarks,error) in
                if let error = error {
                    print(error)
                }else {
                    if let placemark = Placemarks?[0]{
                        var address = ""
                        if placemark.subThoroughfare != nil {
                            address += placemark.subThoroughfare! 
                        }
                     
                        if placemark.thoroughfare != nil {
                           address += placemark.thoroughfare!
                        }
                      
                        if placemark.subLocality != nil{
                            address += placemark.subLocality!
                        }
                    
                        if placemark.subAdministrativeArea != nil{
                           address += placemark.subAdministrativeArea!
                        }
                    
                        if placemark.postalCode != nil{
                        address += placemark.postalCode!
                        }
               
                        if placemark.country != nil{
                        address += placemark.country! 
                        }
                        self.addressLabel.text = address
                    }
                }
            }
            
        }

        
    }


