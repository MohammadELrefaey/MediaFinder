//
//  MediaCellView.swift
//  MediaFinder
//
//  Created by Mohamed on 12/24/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class MediaCellView: UITableViewCell {
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var GenreLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // get image from API
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
            }

        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])

            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }

    // configure media cell
       func configure(media: Media) {
            let image = getImage(from: media.image)
        
            mediaImageView.image = image
            titleLbl.text = media.title
            yearLbl.text = String(media.releaseYear)
            ratingLbl.text = String(media.rating)
            GenreLbl.text = media.genre.joined(separator: ",")
       }

}
