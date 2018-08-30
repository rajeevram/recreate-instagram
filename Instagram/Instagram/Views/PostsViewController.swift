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
        postsTableView.rowHeight = 270
        fetchPostsData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchPostsData() {
        // Create New PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // Fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.postsTableView.reloadData()
            }
            else {
                print(error.debugDescription)
            }
        })
    }
    
    // Event Handlers
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
    
    // Delegate,Protocol Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    cell.postImageView.image = UIImage(data: data!)
                }
            }
        }
        cell.captionLabel.text = post.caption
        return cell
    }
    
}
