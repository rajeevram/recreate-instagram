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
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            else {
                self.displayLoginErrorAlert()
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameTextField.text!
        newUser.password = passwordTextField.text!
        newUser.signUpInBackground { (success, error) in
            if (success) {
                self.displaySignupSuccessAlert()
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            else {
                self.displaySignupErrorAlert()
            }
        }
    }
    
    // Display Alert Methods
    func displayLoginErrorAlert() {
        let alertController = UIAlertController(title: "Login Failed!", message: "Please enter a valid username and password combination.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        present(alertController, animated: true) {
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
    
    func displaySignupErrorAlert() {
        let alertController = UIAlertController(title: "Signup Failed!", message: "That username is already taken. Please choose another one.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        present(alertController, animated: true) {
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
    
    func displaySignupSuccessAlert() {
        let alertController = UIAlertController(title: "Signup Successfuly!", message: "New account created.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Continue", style: .default)
        alertController.addAction(dismissAction)
        present(alertController, animated: true) { }
    }
    
}
