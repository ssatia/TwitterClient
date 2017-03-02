//
//  TweetDetailsViewController.swift
//  TwitterDemo
//
//  Created by Sanyam Satia on 3/1/17.
//  Copyright © 2017 Sanyam Satia. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyIcon: UIImageView!
    @IBOutlet weak var retweetIcon: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        tweetLabel.text = tweet.text
        usernameLabel.text = tweet.username
        handleLabel.text = "@" + tweet.handle!
        
        if tweet.profileImageUrl != nil {
            profileImageView.setImageWith(tweet.profileImageUrl!)
        }
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy, HH:mm"
        let dateString = dateFormatter.string(from: tweet.timeStamp!)
        timestampLabel.text = dateString
        
        updateRetweetCount()
        updateFavoriteCount()
        
        let replyTapGesture = UITapGestureRecognizer(target: self, action: #selector(TweetDetailsViewController.replyIconClicked(gesture:)))
        replyIcon.addGestureRecognizer(replyTapGesture)
        replyIcon.isUserInteractionEnabled = true
        
        let retweetTapGesture = UITapGestureRecognizer(target: self, action: #selector(TweetCell.retweetIconClicked(gesture:)))
        retweetIcon.addGestureRecognizer(retweetTapGesture)
        retweetIcon.isUserInteractionEnabled = true
        
        let favoriteTapGesture = UITapGestureRecognizer(target: self, action: #selector(TweetCell.favoriteIconClicked(gesture:)))
        favoriteIcon.addGestureRecognizer(favoriteTapGesture)
        favoriteIcon.isUserInteractionEnabled = true
    }
    
    func replyIconClicked(gesture: UIGestureRecognizer) {
        performSegue(withIdentifier: "replyTweetSegue", sender: nil)
    }
    
    func updateRetweetCount() {
        if tweet.retweetCount! > 0 {
            retweetCountLabel.text = "\(tweet.retweetCount!)"
        } else {
            retweetCountLabel.text = ""
        }
    }
    
    func updateFavoriteCount() {
        if tweet.favoriteCount! > 0 {
            favoriteCountLabel.text = "\(self.tweet.favoriteCount!)"
        } else {
            favoriteCountLabel.text = ""
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ComposeTweetViewController
        viewController.defaultText = "@" + tweet.handle! + " "
        viewController.replyStatusId = tweet.id
    }

}
