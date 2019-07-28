

import UIKit

class MediaListViewController: UIViewController {
    
    
    var dataSource: [MediaBrief] {
        return DataManager.shared.mediaList
    }


    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        loadData()
    }
    
    // Loading api data
    func loadData() {
        MediaService.getMediaList(term: "mix") { (success, list) in
            
            if success, let list = list {
                DataManager.shared.mediaList = list
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            }
            else {
                // show no data alert
                    self.presentNoDataAlert(title: "Oops, something happened...",
                                            message: "Couldn't load any fun stuff for you:(")
                
            }
            
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
    
    
    
    func config() {
        navigationItem.title = "Now Listen!"
        
        
        view.backgroundColor = .red
        view.backgroundColor = UIColor.UIPalette.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewFlowLayout.scrollDirection = .vertical
    }
    
}

extension MediaListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListMediaCell", for: indexPath) as! ListCollectionViewCell
        let mediaBrief = dataSource[indexPath.item]
        cell.populate(mediaBrief: mediaBrief)
        
        // to load the image into the cell
        if let artworkData = mediaBrief.artworkData,
            let artwork = UIImage(data: artworkData) {
            cell.setImage(image: artwork)
        }
        else if let imageURL = URL(string: mediaBrief.artworkUrl) {
            MediaService.getImage(imageUrl: imageURL, completion: { (success, imageData) in
                if success, let imageData = imageData,
                    let artwork = UIImage(data: imageData) {
                    mediaBrief.artworkData = imageData
                    DispatchQueue.main.async {
                        cell.setImage(image: artwork)
                    }
                    
                }
            })
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMediaDetails",
            let cell = sender as? ListCollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell),
            let mediaDetailViewController = segue.destination as? MediaDetailViewController {
            let mediaBrief = dataSource[indexPath.item]
            
            mediaDetailViewController.mediaId = mediaBrief.id
        }
    }
}

extension MediaListViewController: UICollectionViewDelegate {
}

extension MediaListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = collectionView.frame.size.width
        return CGSize(width: (w - 20)/2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

extension UIColor {
    
    static let sunshine = UIColor.yellow
    static let forest = UIColor.green
    
    struct UIPalette {
        static let backgroundColor = UIColor.red
        static let titleColor = UIColor.forest
        static let subtitleColor = UIColor.blue


}
}
