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
    
    /*----------UI, UX Outlet Variables----------*/
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var postsTableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    /*----------Backend Support Fields----------*/
    var posts: [Post] = []
    
    /*----------ViewDidLoad() Method----------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup pull-to-refresh functionality
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPostsData), for: .valueChanged)
        postsTableView.insertSubview(refreshControl, at: 0)
        
        // Setup delegate, data source, and dimensions
        postsTableView.delegate = self as UITableViewDelegate
        postsTableView.dataSource = self as UITableViewDataSource
        postsTableView.rowHeight = UITableViewAutomaticDimension
        postsTableView.estimatedRowHeight = 100
        
        // Retrieve posts and update table view
        fetchPostsData()
        postsTableView.reloadData()
        
    }
    
    /*----------Network Request Method----------*/
    
    // This method is called to retrieve the information from Parse
    @objc func fetchPostsData() {
        
        // Create a new Parse query and specify the parameters of the request
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("createdAt")
        query?.limit = 20
        
        // Fetch the data asynchronously from Parse
        query?.findObjectsInBackground(block: { (posts, error) in
            // If we were able to retrieve the data...
            if let posts = posts {
                // ...populate the array of posts declared in this class
                self.posts = posts as! [Post]
                // ...and refresh the table view
                self.postsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            // Otherwise, find out what went wrong.
            else {
                print(error.debugDescription)
            }
        })
    }
    
    /*----------Event Handlers----------*/
    
    // This function is called when the sign-out button is pressed
    @IBAction func onSignOut(_ sender: Any) {
        // Call static Parse method to logout asynchronously
        PFUser.logOutInBackground { (error) in
            // Check for some sort of error
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        // Perform modal segue with given Storyboard ID if successful
        self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
    }
    
    // This function is called when the new post button is pressed, and
    // perfoms a modal segue to the SelectPhotoViewController
    @IBAction func onCreateNewPost(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateNewPostSegue", sender: nil)
    }
    
    /*----------Table View Methods----------*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.indexPath = indexPath
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
    
    /*----------Prepare For Segue----------*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? DetailViewController
        if let cell = sender as! PostCell? {
            dvc?.post = posts[(cell.indexPath?.row)!]
        }
    }
    
}
