//
//  setTimeViewController.swift
//  crepuscular
//
//  Created by Yishai Basserabie on 2018/09/14.
//  Copyright © 2018 Yishai Basserabie. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class setTimeViewController: UIViewController {
    //creates references for objects in storyboard
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var AMPMSegmentedControl: UISegmentedControl!
    
    //declares boolean checking if AM
    var isAM = true
    //accesses the ID of the current user and stores it in a var
    var userID: String = (Auth.auth().currentUser?.uid)!
    
    //declares a reference to database
    var ref: DatabaseReference?
    
    //creates numeric index of users and times
    var ind = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //initialises reference to database connecting to googleService-info.plist
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //function flipping am value
    @IBAction func isAM(_ sender: UISegmentedControl) {
        //flips value of boolean
        isAM = !isAM
    }
    
    // TODO: fix pushing of time to database!!
    @IBAction func setTime(_ sender: UIButton) {
        //creates pathway for hour and sets value to the text of hourTextField
        ref?.child("users").child(userID).child("wakeUpTime").child("hour").setValue(hourTextField.text)
        //creates pathway for minute and sets value to the text of minuteField
        ref?.child("users").child(userID).child("wakeUpTime").child("minute").setValue(minutesTextField.text)
        //creates pathway for am/pm and sets value to the text of isAM
        ref?.child("users").child(userID).child("wakeUpTime").child("isAM").setValue(isAM)
    }
    
}
