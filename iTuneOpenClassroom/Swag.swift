

import Foundation

import UIKit

import Foundation

class Swag {
    var id: Int
    var title: String
    var artworkUrl: String
    var sourceUrl: String
    
    var artworkData: Data?
    
    init(id: Int, title: String, artworkUrl: String, sourceUrl: String) {
        self.id = id
        self.title = title
        self.artworkUrl = artworkUrl
        self.sourceUrl = sourceUrl
    }
}

