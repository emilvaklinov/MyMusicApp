//
//  iTunesAppleTests.swift
//  iTunesAppleTests
//
//  Created by Emil Vaklinov on 28/07/2019.
//  Copyright © 2019 project. All rights reserved.
//

import Foundation
import UIKit

class MediaBrief {
    var id: Int
    var title: String
    var artistName: String
    var artworkUrl: String
    
    var artworkData: Data?
    
    init(id: Int, title: String, artistName: String, artworkUrl: String) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.artworkUrl = artworkUrl
    }
}

class Media: MediaBrief {
    var collection: String?
    var sourceUrl: String
    
    init(id: Int, title: String, artistName: String, artworkUrl: String, sourceUrl: String) {
        self.sourceUrl = sourceUrl
        super.init(id: id, title: title, artistName: artistName, artworkUrl: artworkUrl)
    }
}
