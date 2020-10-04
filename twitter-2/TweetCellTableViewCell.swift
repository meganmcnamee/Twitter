//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by user178618 on 9/28/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    //setting favor icon actions
    var favorited:Bool = false
    var tweetId:Int = -1
        
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId , success: {
                self.setFavorite(isFavorited: true)
                }, failure: { (error) in
                    print("Favorite did not succeed: \(error)")
                })
        } else {
        
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId , success: {
                self.setFavorite(isFavorited: false)
                }, failure: { (error) in
                    print("unFavorite did not succeed: \(error)")
                })
            
        }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweetId: tweetId , success : {
            self.setRetweeted(_isRetweeted: true)
        }, failure : { (error) in
            print("Error retweeting: \(error)")
        
        })
    }
    
    func setRetweeted(_isRetweeted:Bool) {
        if (_isRetweeted){
        retweetButton.setImage(UIImage(named: "retweet-icon-green"), for:
            UIControl.State.normal)
        retweetButton.isEnabled = false
        }
        else{
        retweetButton.setImage(UIImage(named: "retweet-icon"), for:
            UIControl.State.normal)
        retweetButton.isEnabled = true
        }
    }
    
    func setFavorite(isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for:
                                UIControl.State.normal)}
        else{
            favButton.setImage(UIImage(named:"favor-icon"), for:
                                UIControl.State.normal)
        }
    }
    
    @IBOutlet weak var retweetButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
