//
//  linkUpViewController.swift
//  rays
//
//  Created by Yishai Basserabie on 2018/10/21.
//  Copyright © 2018 Yishai Basserabie. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseDatabase

class linkUpViewController: UIViewController, CLLocationManagerDelegate {
    //creates reference to mapView
    @IBOutlet weak var map: MKMapView!
    //creates reference for locationManager
    var locationManager = CLLocationManager()
    //creates database reference
    var ref: DatabaseReference?
    //accesses the ID of the current user and stores it in a var
    var userID: String = (Auth.auth().currentUser?.uid)!
    //creates avriable for partner lat
    var partnerLocLat = ""
    //creates avriable for partner long
    var partnerLocLong = ""
    //creates var for master index
    var masterIndexVar = Int()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //initiates database reference
        ref = Database.database().reference()
        //asks for permission to use location
        self.locationManager.requestWhenInUseAuthorization()
        
        //checks if permission granted
        if CLLocationManager.locationServicesEnabled() {
            //initiates locationManager
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        //calls write location func
        writeLocation()
        readIndex()
        delegateIndexFromMasterIndex()
    }
    //function handling location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //sets location
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        //sets region visable on mapView
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 100, longitudinalMeters: 100)
        self.map.setRegion(viewRegion, animated: true)
    }
    
    //function writes location data
    func writeLocation() {
        //creates path location and adds latitude
    ref?.child("users").child(userID).child("location").child("lat").setValue(locationManager.location?.coordinate.latitude)
        //adds longitude
        ref?.child("users").child(userID).child("location").child("long").setValue(locationManager.location?.coordinate.longitude)
    }
    //TODO: FIX READING OF MASTER INDEX
    //function reads master index
    func readIndex() {
        //creates snapshot of masterIndex
        ref?.child("globalVars").child("masterIndex").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? Int ?? 44
            let indexRead = value
            print(indexRead)
        }) { (error) in
            print(error.localizedDescription)
            print("hahahahahahahahahahaha")
        }
    }
    
    
    //function giving each user an index
    func delegateIndexFromMasterIndex() {
        //creates variable to store read master index
        let readIndex = self.masterIndexVar
        let myIndex = readIndex + 1
        //writes my own index into profile on database
        ref?.child("users").child(userID).child("myIndex").setValue(myIndex)
        //rewrites the masterIndex adding one to it denoting a new user
        ref?.child("globalVars").child("masterIndex").setValue(myIndex)
        print(readIndex)
    }
    
    
    
}
