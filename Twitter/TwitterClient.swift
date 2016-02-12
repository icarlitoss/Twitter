//
//  TwitterClient.swift
//  Twitter
//
//  Created by Carlos Osco Huaricapcha on 2/11/16.
//  Copyright © 2016 Carlos Osco Huaricapcha. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "MaOxVDffpuPuRgq9axR7suzpY"
let twitterConsumerSecret = "o2sww0Vd9lCCM9fEgyfrPb01GlGOiAnGKCXBRHHjtoOCsbZTvB"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    
    
    class var sharedInstance: TwitterClient {
        struct Static{
            static let instance =  TwitterClient(baseURL: twitterBaseURL ,consumerKey: twitterConsumerKey , consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }

    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: params, success: {(operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("home timeline: \(response)")}
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            for tweet in tweets {
                print("text: \(tweet.text), created: \(tweet.createdAt) ")
            }
            
            completion(tweets: tweets, error: nil)
            
            },failure: {(operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
                
                
        })
        
    }
    
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        //Fetch request token & redirect to authorization page
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "ctptwitterCarlos://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            
            })
            { (error: NSError!) ->Void in
                print("Error gettin the request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
        
    }
    
    
    
    func openURL(url: NSURL){
        
       fetchAccessTokenWithPath(
            "oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query),
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                print("Got the access token!")
                
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                
                
                
                
                TwitterClient.sharedInstance.GET(
                    "1.1/account/verify_credentials.json",
                    parameters: nil,
                    success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                        //print("user: \(response!)")
                        
                        var user = User(dictionary: response as! NSDictionary)
                        
                        User.currentUser = user
                        
                        
                        print("user: \(user.name)")
                        self.loginCompletion?(user: user, error: nil)
                    
                    }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                        print("error getting current user")
                        self.loginCompletion?(user: nil, error: error)
                        
                })
                
                
        
            }, failure: { (error: NSError!) -> Void in
                print("Fail to receive access token")
                self.loginCompletion?(user: nil, error: error)
        })

    }
    
    
    
}
