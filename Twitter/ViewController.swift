//
//  ViewController.swift
//  Twitter
//
//  Created by Carlos Osco Huaricapcha on 2/11/16.
//  Copyright © 2016 Carlos Osco Huaricapcha. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
       
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
          TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestWithToken("oauth/request_token", method: "GET", callbackURL: NSURL(string: "ctptwitterCarlos://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in print("Got the request token")})
            { (error: NSError!) ->Void in
                print("Error gettin the request token: \(error)")
        }
        
    }

}

