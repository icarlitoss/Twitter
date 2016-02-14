//
//  TweetsCell.swift
//  Twitter
//
//  Created by Carlos Osco Huaricapcha on 2/12/16.
//  Copyright © 2016 Carlos Osco Huaricapcha. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userHandle: UILabel!
    
    @IBOutlet weak var tweetContentText: UILabel!

    @IBOutlet weak var createdTime: UILabel!
    

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //changing the radius of the image
        
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
        
        //for the autoLayout
        userName.preferredMaxLayoutWidth = userName.frame.size.width
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
     userName.preferredMaxLayoutWidth = userName.frame.size.width
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
