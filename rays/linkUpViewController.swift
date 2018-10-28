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
    var masterIndexVar = String()
   
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
//        ref?.child("globalVars").observeSingleEvent(of: .value, with: { (snapshot) in
//            var count = snapshot.children.allObjects.count
//            let value = snapshot.value as! NSDictionary
//            let readIndex = value["masterIndex"] as? String ?? "agaga"
//            let index = User(readIndex: readIndex)
//            self.masterIndexVar = index
//            print(value)
//            print("\(self.masterIndexVar) + 343haga")
//            print("\(count) + tytyt")
//        }) { (error) in
//            print(error.localizedDescription)
//            print("hahahahahahahahahahaha")
//        }
        
        ref?.child("globalVars").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSMutableDictionary
            let index = value?["masterIndex"] as? String ?? ""
            let realindex = index
//            let final = (index: String())
            self.masterIndexVar = realindex
            print(self.masterIndexVar)
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    
    //function giving each user an index
    func delegateIndexFromMasterIndex() {
        //creates variable to store read master index
        let readIndex = self.masterIndexVar
        let myIndex = (Int(readIndex) ?? 23) + 1
        //writes my own index into profile on database
        ref?.child("users").child(userID).child("myIndex").setValue(myIndex)
        //rewrites the masterIndex adding one to it denoting a new user
        ref?.child("globalVars").child("masterIndex").setValue(myIndex)
        print(readIndex)
    }
    
    
    
}

