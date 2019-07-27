

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
    }
    
    func config() {
        navigationItem.title = "Now ListenUp!"
        
        
        view.backgroundColor = .sunshine
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
        return CGSize(width: (w - 20)/2, height: 290)
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
        static let backgroundColor = UIColor.sunshine
        static let titleColor = UIColor.forest
        static let subtitleColor = UIColor.blue


}
}
