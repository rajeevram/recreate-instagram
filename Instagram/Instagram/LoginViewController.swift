//
//  LoginViewController.swift
//  Instagram
//
//  Created by Rajeev Ram on 8/10/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    // UI, UX Variables
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    // Superclass Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Event Handlers
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            if (user != nil) {
                print("Already logged in!")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameTextField.text!
        newUser.password = passwordTextField.text!
        newUser.signUpInBackground { (success, error) in
            if (success) {
                print("New user created!")
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
}
