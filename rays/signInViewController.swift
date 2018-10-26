//
//  signInViewController.swift
//  crepuscular
//
//  Created by Yishai Basserabie on 2018/09/14.
//  Copyright © 2018 Yishai Basserabie. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth

class signInViewController: UIViewController {
    
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var isLogin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        //flip the boolean
        isLogin = !isLogin
        //check the boolean and chenges labels and button
        if isLogin {
            loginLabel.text = "login!"
            loginButton.setTitle("login!", for: .normal)
        } else {
            loginLabel.text = "sign up!"
            loginButton.setTitle("sign up!", for: .normal)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        //check if login or sign up
        if isLogin {
            //login user with Firebase
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                //checks if login works
                if user != nil {
                    //user found
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                } else {
                    //error found
                }
            }
        } else {
            //register user with Firebase
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
                //checks if sign up works
                if authResult?.user != nil {
                    //sign up good
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                } else {
                    //sign up failed
                }
                
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dissmiss the keyboard when view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func adminButton(_ sender: UIButton) {
        emailTextField.text = "yishibass@gmail.com"
        passwordTextField.text = "Macbookpro1"
    }
    
}

