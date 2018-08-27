//
//  AuthenticatedViewController.swift
//  Instagram
//
//  Created by Rajeev Ram on 8/12/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import Parse

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // UI, UX Outlet Variables
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var postsTableView: UITableView!
    
    // Backend Logic Variables
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.delegate = self as UITableViewDelegate
        postsTableView.dataSource = self as UITableViewDataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onSignOut(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
    }
    
    @IBAction func onCreateNewPost(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateNewPostSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        return cell
    }
    
}
