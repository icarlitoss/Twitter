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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
