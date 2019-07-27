

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
                                   title: "fakeTitle \(i)",
                artistName: "fake artist",
                artworkUrl: "https://is4-ssl.mzstatic.com/image/thumb/Music/v4/33/ed/8e/33ed8eb0-4768-c14a-7e21-c421b9647e09/source/100x100bb.jpg")
            list.append(media)
        }
        
        return list
    } ()
    
    func swagForMedia(_ media: Media?) -> Swag? {
        let swag = Swag(id: 0,
                        title: "Cool stuff!",
                        artworkUrl: "https://is4-ssl.mzstatic.com/image/thumb/Music/v4/33/ed/8e/33ed8eb0-4768-c14a-7e21-c421b9647e09/source/100x100bb.jpg",
                        sourceUrl: "http://openclassrooms.com")
        return swag
    }
}
