//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Jesse Oseafiana on 9/30/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var greyFavButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    @IBOutlet weak var greyRetButton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: {
                (error) in
                print("Favorite did not suceed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: {
                (error) in
                print("Unfavorite did not suceed: \(error)")
            })
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweetTweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: {
            (error) in
            print("Error is retweeting: \(error)")
        })
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if (isRetweeted) {
            greyRetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            greyRetButton.isEnabled = false
        } else {
            greyRetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            greyRetButton.isEnabled = true
        }
    }
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            greyFavButton.setImage(UIImage(named: "favor-icon-red"),
                                   for: UIControl.State.normal)
        } else {
            greyFavButton.setImage(UIImage(named: "favor-icon"),
                                   for: UIControl.State.normal)
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
