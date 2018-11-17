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

    /*----------UI, UX Outlet Variables----------*/
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    /*----------Event Handlers----------*/
    
    // This function is called when pressing the sign-in button
    @IBAction func onSignIn(_ sender: Any) {
        // Access the Parse databse to verify the correct login credentials
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            // Perform modal segue with given Storyboard ID if successful
            if (user != nil) {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            // Otherwise, call a function to display an error alert
            else {
                self.displayLoginErrorAlert()
            }
        }
    }
    
    // This function is called when pressing the sign-up button
    @IBAction func onSignUp(_ sender: Any) {
        // Create a new Parse user and set its fields
        let newUser = PFUser()
        newUser.username = usernameTextField.text!
        newUser.password = passwordTextField.text!
        // Once the user is created, save the object in the Parse database
        newUser.signUpInBackground { (success, error) in
            // If the username did not already exist, display a success alert
            if (success) {
                self.displaySignupSuccessAlert()
                //self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            // Otherwise, call a function to display an error alert
            else {
                self.displaySignupErrorAlert()
            }
        }
    }
    
    /*----------Display Alert Methods----------*/
    
    // This function is called whenever the sign-in credentials are incorrect. or whenever
    // the sign-up credentials are duplicate, i.e., the user already exists
    func displayLoginErrorAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Login Failed!", message: "Please enter a valid username and password combination.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        // Present the alert and run code to clear the fields in the completing block
        present(alertController, animated: true) {
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
    
    // This function is called whenever the sign-up credentials are duplicate, i.e.,
    // the user already exists in the database
    func displaySignupErrorAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Signup Failed!", message: "That username is already taken. Please choose another one.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        // Present the alert and run code to clear the fields in the completion block
        present(alertController, animated: true) {
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
    
    // The function is called when the user signs-up successfully
    func displaySignupSuccessAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Signup Successful!", message: "New account created.", preferredStyle: .alert)
        // Allow the modal segue to occur when the alert is dismissed
        let dismissAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
        // Present the alert to the user
        alertController.addAction(dismissAction)
        present(alertController, animated: true) { }
    }
    
}
