//
//  Tweet.swift
//  Twitter
//
//  Created by Carlos Osco Huaricapcha on 2/12/16.
//  Copyright © 2016 Carlos Osco Huaricapcha. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    // (#5R) here for the favCount and retweetCount
    var id: String
    var retweedCount: Int?
    var favCount: Int?
    
    
    
    //  (#5R) ended the favCount and retweetCount
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        //  (#5R)  here for the favCount and retweetCount
       id = String(dictionary["id"]!)   //<-not sure about this string
        
        retweedCount = dictionary["retweet_count"] as? Int
        favCount = dictionary["favorite_count"] as? Int
        
        
        
         // (#5R) ended the favCount and retweetCount
        
        
        
    }

    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
    
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
    
        return tweets
    }

    
}
