//
//  IGFeedPostTableViewCell.swift
//  InstaScroll
//
//  Created by Ryan Cummins on 2/16/21.
//

import AVFoundation
import SDWebImage
import UIKit


/// Cell for primary post content
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = nil
        iv.clipsToBounds = true
        return iv
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        
        postImageView.image = UIImage(named: "test") //debug
        return
        
        // Configure the cell
        switch post.postType {
        case .photo:
            // show photo
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            // load and play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

}
