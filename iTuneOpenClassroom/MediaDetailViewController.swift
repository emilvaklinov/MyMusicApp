

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

        // Do any additional setup after loading the view.
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
