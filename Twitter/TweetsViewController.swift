//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Carlos Osco Huaricapcha on 2/12/16.
//  Copyright © 2016 Carlos Osco Huaricapcha. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
   /*
    
    //refresh
    var refreshControl: UIRefreshControl!
*/
    
    @IBOutlet weak var tableView: UITableView!
    
  /*
    //pulling to refresh
    
    func pullToRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }
*/    

    func delay(delay: Double, closure: () -> () ) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure
        )
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //adding the tableview
        tableView.delegate = self
        tableView.dataSource = self
        //for the autolayout of the tableview row
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        
        tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets;
            
            self.tableView.reloadData();
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tvds (tableview data source implementation)
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    
    
    func testTweets() {
        let tweet = tweets![0];
        print(tweet.user!.name);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
        
        cell.profileImage.setImageWithURL(NSURL(string: tweets![indexPath.row].user!.profileImageUrl!)!);
        cell.userName.text = tweets![indexPath.row].user!.name!
        cell.userHandle.text = "@" + (tweets![indexPath.row].user!.screenname!)
        cell.tweetContentText.text = tweets![indexPath.row].text!
        cell.createdTime.text = tweets![indexPath.row].createdAtString!
        
        return cell

    }
    
    //tvds ends here
    
    
    
    
    
    
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        
        //to add the segue from home to login
        self.performSegueWithIdentifier("logoutSegue", sender: self)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
