//
//  iTunesAppleTests.swift
//  iTunesAppleTests
//
//  Created by Emil Vaklinov on 28/07/2019.
//  Copyright © 2019 project. All rights reserved.
//

import UIKit

class MediaDetailViewController: UIViewController {
    
    
    @IBOutlet weak var artworkImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var collectionLabel: UILabel!
    
    @IBOutlet weak var storeButton: UIButton!
    
    
    @IBOutlet weak var swagImageView: UIImageView!
    
    @IBOutlet weak var swagImageLabel: UILabel!
    
    var mediaId: Int!
    
    private var swag: Swag?
    private var media: Media?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        view.backgroundColor = UIColor.UIPaletteTwo.backgroundColor
//        
//        artworkImageView.layer.cornerRadius = artworkImageView.frame.size.width / 2;
//        artworkImageView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        
        swagImageView.layer.cornerRadius = swagImageView.frame.size.width / 2;
        swagImageView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)

    }
    


    
    

    
    func loadData() {
        
        MediaService.getMedia(id: mediaId) { (success, media) in
            if success, let media = media {
                self.media = media
                self.swag = DataManager.shared.swagForMedia(media)
                DispatchQueue.main.async {
                    self.populateMedia()
                    self.populateSwag()
                }
            }
            else {
                self.presentNoDataAlert(title: "Oops, something happened...",
                                        message: "Couldn't load media details")
            }
        }
        
    }
    
    func populateMedia() {
        guard let media = self.media else {
            return
        }
        
        titleLabel.text = media.title
        artistLabel.text = media.artistName
        collectionLabel.text = media.collection
        
        if let imageURL = URL(string: media.artworkUrl) {
            MediaService.getImage(imageUrl: imageURL, completion: { (success, imageData) in
                if success, let imageData = imageData,
                    let artwork = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.artworkImageView.image = artwork
                    }
                }
            })
        }
    }
    
    func populateSwag() {
        guard let swag = self.swag else {
            return
        }
        
        swagImageLabel.text = swag.title
        
        if let imageURL = URL(string: swag.artworkUrl) {
            MediaService.getImage(imageUrl: imageURL, completion: { (success, imageData) in
                if success, let imageData = imageData,
                    let artwork = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.swagImageView.image = artwork
                    }
                }
            })
        }
    }
    
    
    func openURL(sourceUrl: String?) {
        if let sourceUrl = sourceUrl, let url = URL(string: sourceUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            self.presentNoDataAlert(title: "Oops, something happened...",
                                    message: "Try Again!")
        }
    }
    
    func presentNoDataAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Got it", style: .cancel, handler: { (action) -> Void in
        })
        
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    @IBAction func storeButtonTapped(_ sender: Any) {
        openURL(sourceUrl: media?.sourceUrl)
    }
    
    @IBAction func swagTapped(_ sender: Any) {
        openURL(sourceUrl: swag?.sourceUrl)
    }
    
    
}

extension UIColor {
    
    static let sunshineTwo = UIColor.yellow
    static let forestTwo = UIColor.green
    
    struct UIPaletteTwo {
        static let backgroundColor = UIColor.red
        static let titleColor = UIColor.forest
        static let subtitleColor = UIColor.blue
        
        
    }
}


