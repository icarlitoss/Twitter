//
//  DetailViewController.swift
//  Twitter
//
//  Created by Carlos Osco Huaricapcha on 2/25/16.
//  Copyright © 2016 Carlos Osco Huaricapcha. All rights reserved.
//

import UIKit
import SwiftMoment

class DetailViewController: UIViewController {

    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var detailUserHandle: UILabel!
    
    @IBOutlet weak var detailTweetContentText: UILabel!
    
    @IBOutlet weak var createdTime: UILabel!
    
    //buttons outlets
    @IBOutlet weak var replyImageView: UIButton! //image lol
    
    @IBOutlet weak var replyButton: UIButton!
    
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    
    //done buttons outlets
    
    //adding the labels counting
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favCountLabel: UILabel!
    
    
    //now adding the image for the buttons
    
    
    @IBOutlet weak var retweetImageView: UIImageView!
    
    @IBOutlet weak var favImageView: UIImageView!
    
    
    //...
    var replyTo: String?
    var replyID: Int?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var tweetar: Tweet!
    var timeSpanText: String?
    var liked: Bool = false
    var retweeted: Bool = false
    private var detailTweets =  [Tweet]()

    //...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProfile()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //getting the profile function
    
    func showProfile(){
        userName.text = tweetar!.user!.name!
        detailUserHandle.text = ("@\(tweetar!.user!.screenname!)")
        detailTweetContentText.text = tweetar!.text!
        detailImageView.setImageWithURL(NSURL(string: tweetar!.user!.profileImageUrl!)!)
        //timeLabel.text = timeSpanText  //displays timeSpan
        let tweetDate = parseTwitterDate("\(tweetar!.createdAt!)")
        createdTime.text = tweetDate
        //print("this is the date \(tweetDate)")
        favCheck()
        retweetCheck()
        
        replyID = tweetar.id!
        //print("is issssss\(replyID)")
        replyTo = detailUserHandle.text
        userDefaults.setValue(replyID, forKey: "detailReplyTo_ID")
        userDefaults.setValue(replyTo, forKey: "detailReplyTo_Handle")
    }

    //for the time to look nice//
    //Shows the date in proper formate
    func parseTwitterDate(twitterDate:String)->String?{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        let indate = formatter.dateFromString(tweetar!.createdAtString!)
        let outputFormatter = NSDateFormatter()
        outputFormatter.dateFormat = "h:mm a · dd MMM yy"
        var outputDate:String?
        if let d = indate {
            outputDate = outputFormatter.stringFromDate(d)
        }
        return outputDate;
    }
    //finished time to look nice
    
    
    
    //to add the animation. fav and retweet
    //Action to retweet/unretweet animation
    @IBAction func onRetweetClicked(sender: AnyObject) {
        if retweeted == false {
            TwitterClient.sharedInstance.retweet(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.retweeted = true
                print("You retweeted: \(self.tweetar!.user!.name!)'s post")
                //self.tweetar.retweetCount += 1
                
                //trying to reduce the count size once goes over 1000
                let tweetCountNum = Int (self.tweetar.retweetCount += 1)
                print("num is \(tweetCountNum)")
                if tweetCountNum >= 1000 {
                    print("num2 is \(tweetCountNum)")
                    
                    let finaTweetCountNum = tweetCountNum / 1000
                    print("num3 is \(finaTweetCountNum)k")
                    
                    self.retweetCountLabel.text = "\(finaTweetCountNum)k)"
                    
                }
                else {
                    // self.retweetLabel.text = "\(tweetCountNum)"
                }
                self.retweetImageView.image = UIImage(named: "retweet-clicked")
                self.retweetCheck()
            }
        }else{
            TwitterClient.sharedInstance.unRetweet(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.retweeted = false
                print("You unretweeted: \(self.tweetar!.user!.name!)'s post")
                self.tweetar!.retweetCount -= 1
                self.retweetCountLabel.text = "\(self.tweetar!.retweetCount)"
                self.retweetImageView.image = UIImage(named: "retweet")
                self.retweetCheck()
            }
        }
    }
    
    //Action to fav/ and not fav 
    
    
    @IBAction func onFavClicked(sender: AnyObject) {
        if liked == false {
            TwitterClient.sharedInstance.favTweet(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.liked = true
                print("You liked: \(self.tweetar!.user!.name!)'s post")
                self.tweetar.favCount += 1
                
                var likeCountNum = self.tweetar!.favCount
                if likeCountNum > 1000 {
                    likeCountNum = likeCountNum / 1000
                }
                
                self.favCountLabel.text = "\(likeCountNum)"
                self.favImageView.image = UIImage(named: "like-clicked")
                
                self.favCheck()
            }
        }else{
            TwitterClient.sharedInstance.unFavTweet(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.liked = false
                print("You unliked: \(self.tweetar!.user!.name!)'s post")
                self.tweetar!.favCount -= 1
                self.favCountLabel.text = "\(self.tweetar!.favCount)"
                self.favImageView.image = UIImage(named: "like")
                
                self.favCheck()
            }
        }
    }
    
    
    func favCheck(){
        //display text only when likes, else hides
        let favCounts = tweetar!.favCount as Int
        if favCounts == 0 {
            //likesText.text = ""
            favCountLabel.text = ""
        } else {
            favCountLabel.text = "\(tweetar!.favCount as Int)"
            //likesText.text = "LIKES"
        }
    }
    
    
    func retweetCheck(){
        //display text only when likes, else hides
        let retweetCounts = tweetar!.retweetCount as! Int
        if retweetCounts == 0 {
            //retweetText.text = ""
            retweetCountLabel.text = ""
        } else {
            retweetCountLabel.text = "\(tweetar!.retweetCount as! Int)"
            //retweetText.text = "RETWEETS"
        }
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
