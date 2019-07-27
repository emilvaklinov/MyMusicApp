

import Foundation

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {
    }
    
    lazy var mediaList: [MediaBrief] = {
        var list = [MediaBrief]()
        
        for i in 0 ..< 10 {
            let media = MediaBrief(id: 486040195,
                                   title: "Title \(i)",
                artistName: "Artist",
                artworkUrl: "https://i.postimg.cc/gkVBsrVD/itunes-macos-icon-240.png")
            
            list.append(media)
        }

        return list
    }()
    
    func swagForMedia(_ media: Media?) -> Swag? {
        let swag = Swag(id: 0,
                        title: "Click for Cool stuff!",
                        artworkUrl: "https://i.postimg.cc/gkVBsrVD/itunes-macos-icon-240.png",
                        sourceUrl: "https://www.musixhub.com")
        return swag
    }
}

