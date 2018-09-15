//
//  CodableAlbum.swift
//  WStest
//
//  Created by Sebastian Cohausz on 12.08.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import Foundation
struct Album: Category {
    static func browseComponent(parentItem: Category?) -> BrowseComponent! {
        return AlbumBrowseComponent(parentItem: parentItem)
    }
    
    
    let artist: String
    let title: String
    let uri: String //relative location
    let type: String
    let albumArt: String //relative location
    let service: String
    
    enum CodingKeys: String, CodingKey {
        case artist
        case title
        case uri
        case type
        case albumArt = "albumart"
        case service
    }
    
    static var categoryType: CategoryType = .album
}
