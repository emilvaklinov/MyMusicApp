//
//  ListCollectionViewCell.swift
//  iTunesApple
//
//  Created by Emil Vaklinov on 12/03/2020.
//  Copyright © 2020 project. All rights reserved.
//

import Foundation
import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var artworkImageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    
    
    
    func populate(mediaBrief: MediaBrief) {
        titleLabel.text = mediaBrief.title
        artistLabel.text = mediaBrief.artistName
    }
    
    func setImage(image: UIImage?) {
        artworkImageView.image = image
    }
}
