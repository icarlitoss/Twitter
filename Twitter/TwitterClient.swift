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
    
    class var sharedInstance: TwitterClient {
        struct Static{
            static let instance =  TwitterClient(baseURL: twitterBaseURL ,consumerKey: twitterConsumerKey , consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }

}
