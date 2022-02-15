//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by 安益廷 on 2/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetbutton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("favorite did not succeed \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("unfavorite did not succeed \(Error)")
            })
        }
    }
    
    
    
    var favorited:Bool = false
    var tweetID:Int = -1
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("retweet failed \(Error)")
        })
    }
    
    func setRetweeted (_ isRetweeted:Bool){
        if(isRetweeted){
            retweetbutton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetbutton.isEnabled = false
        } else {
            retweetbutton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetbutton.isEnabled = true
        }
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
