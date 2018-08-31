//
//  DetailViewController.swift
//  Instagram
//
//  Created by Rajeev Ram on 8/30/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateViewData()
    }
    
    
    func populateViewData() {
        if let imageFile : PFFile = post?.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    self.detailImageView.image = UIImage(data: data!)
                }
            }
        }
        captionLabel.text = post?.caption
        timeStampLabel.text = formatDateString((post?.createdAt)!)
    }
    
    func formatDateString(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let result = formatter.string(from: date)
        return result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToPhotoFeed", sender: nil)
    }
    
    
}
