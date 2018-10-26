//
//  textMessageViewController.swift
//  crepuscular
//
//  Created by Yishai Basserabie on 2018/09/17.
//  Copyright © 2018 Yishai Basserabie. All rights reserved.
//

import UIKit
import Foundation
import CoreFoundation

class textMessageViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //rounds the corners of the text view
        textView.borderStyle = UITextField.BorderStyle.roundedRect
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func b1(_ sender: UIButton) {
        //aligns text field text with button
        textView.text = button1.titleLabel?.text
    }
    @IBAction func b2(_ sender: UIButton) {
        //aligns text field text with button
        textView.text = button2.titleLabel?.text
    }
    @IBAction func b3(_ sender: UIButton) {
        //aligns text field text with button
        textView.text = button3.titleLabel?.text
    }
    @IBAction func b4(_ sender: UIButton) {
        //aligns text field text with button
        textView.text = button4.titleLabel?.text
    }
    @IBAction func b5(_ sender: UIButton) {
        //aligns text field text with button
        textView.text = button5.titleLabel?.text
    }
    @IBAction func b6(_ sender: UIButton) {
        //aligns text field text with button
        textView.text = button6.titleLabel?.text
    }
    @IBAction func b7(_ sender: UIButton) {
        //aligns text field text with button
        textView.text = button7.titleLabel?.text
    }
    
}
