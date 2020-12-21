//
//  MovieCellTableViewCell.swift
//  MediaFinder
//
//  Created by Mohamed on 12/19/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        }
    
    func configure(media: Media) {
        mediaImageView.image = UIImage(named: media.image)
        mediaNameLabel.text = media.name
    }

}
