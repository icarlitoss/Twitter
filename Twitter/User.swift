//
//  User.swift
//  Twitter
//
//  Created by Carlos Osco Huaricapcha on 2/12/16.
//  Copyright © 2016 Carlos Osco Huaricapcha. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"


class User: NSObject {

    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }
    
    /*****************************
    class var currentUser: User? {
        get {
            if _currentUser == nil{
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
        var dictionary  = NSJSONSerialization.JSONObjectWithData(data!, options: nil) as NSDictionary
        _currentUser = User(dictionary: dictionary)
            }
        }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                 NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    
    
    }
    ***********/
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData;
        if data != nil {
        do {
        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions());
        _currentUser = User(dictionary: dictionary as! NSDictionary);
    } catch _ {
        
        }
        }
        }
        return _currentUser;
        }
        set(user) {
            _currentUser = user;
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions());
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey);
                } catch _ {
                    
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey);
            }
            NSUserDefaults.standardUserDefaults().synchronize();
        }
    }
    
}
