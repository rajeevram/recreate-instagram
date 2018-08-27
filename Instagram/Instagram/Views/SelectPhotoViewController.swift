//
//  SelectPhotoViewController.swift
//  Instagram
//
//  Created by Rajeev Ram on 8/27/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UI, UX Outlet Variables
    @IBOutlet weak var photoSelectedImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Event Handlers
    @IBAction func loadCameraPhotoLibrary(_ sender: Any) {
        self.selectPhoto()
    }
    
    @IBAction func postPhoto(_ sender: Any) {
        let caption = captionTextField.text ?? "No Caption"
        let image = photoSelectedImageView.image
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        self.performSegue(withIdentifier: "PostPhotoSegue", sender: nil)
    }
    
    func selectPhoto() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            //print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    // Delegate Protocols
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        photoSelectedImageView.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }


}
