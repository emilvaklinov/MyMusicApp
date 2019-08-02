//
//  iTunesAppleTests.swift
//  iTunesAppleTests
//
//  Created by Emil Vaklinov on 28/07/2019.
//  Copyright © 2019 project. All rights reserved.
//

import Foundation

class DataManager {
    
    // initializing the data manager
    static let shared = DataManager()
    
    // Singleton patern allows us to have only one instance of an object throughout the whole app.
    private init() {
    }
    
    // lazi to be initialized of the first request and store temporary items
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
    
    
    // to genetrate swag based on the media item
    func swagForMedia(_ media: Media?) -> Swag? {
        let swag = Swag(id: 0,
                        title: "Cool MusicHub!",
                        artworkUrl: "https://i.postimg.cc/NjB33ZBR/Funcky.jpg",
                        sourceUrl: "https://www.musixhub.com")
        return swag
    }
}

