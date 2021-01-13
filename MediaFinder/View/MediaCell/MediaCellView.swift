//
//  MediaCellView.swift
//  MediaFinder
//
//  Created by Mohamed on 12/24/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit
import SkeletonView
import SDWebImage
class MediaCellView: UITableViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var fourthLbl: UITextView!
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK:- actions
    @IBAction func imgAnimBtn(_ sender: UIButton) {
        mediaImgAnimate()
    }
}
    //MARK:- Private Methods
extension MediaCellView {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // configure media cell
    func configure(media: Media, mediaType: String) {
        applyingSkeleton()
    
        mediaImageView.sd_setImage(with: URL(string: media.artworkUrl100), placeholderImage: UIImage(named: "media.png"))
        
        if mediaType == MediaType.music {
            firstLbl.text = "Track"
            secondLbl.text = media.trackName
            thirdLbl.text = "Artist"
            fourthLbl.text = media.artistName
        }
        else if mediaType == MediaType.movie {
            firstLbl.text = "Track"
            secondLbl.text = media.trackName
            thirdLbl.text = "Description"
            fourthLbl.text = media.longDescription
        }
        
        else if mediaType == MediaType.tvShow {
            firstLbl.text = "Starring"
            secondLbl.text = media.artistName
            thirdLbl.text = "Description"
            fourthLbl.text = media.longDescription
        }
    }
    
    private func mediaImgAnimate() {
        let wiggleAnime = CABasicAnimation(keyPath: "position")
               wiggleAnime.repeatCount = 5
               wiggleAnime.duration = 0.05
               wiggleAnime.fromValue = CGPoint( x: mediaImageView.center.x - 10.0 , y: mediaImageView.center.y)
               wiggleAnime.toValue = CGPoint( x: mediaImageView.center.x + 10.0 , y: mediaImageView.center.y)
        mediaImageView.layer.add(wiggleAnime, forKey: "position")
    }
    
    private func applyingSkeleton() {
        self.isSkeletonable = true
        self.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute:{
            self.hideSkeleton()
        })
    }
}
