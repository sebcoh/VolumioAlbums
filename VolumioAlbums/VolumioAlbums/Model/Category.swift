//
//  Category.swift
//  WStest
//
//  Created by Sebastian Cohausz on 15.08.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import Foundation

enum CategoryType {
    case artist
    case album
    case genre
    case track
    
    
    var request: String {
        switch self {
        case .album:
            return "albums://"
        case .artist:
            return "artists://"
        case .genre:
            return "genres://"
        case .track:
            return "tracks://"
        }
        
        
    }
    
    var collectionCellId: String {
        switch self {
        case .album:
            return "albumCell"
        case .artist:
            return "artistCell"
        case .genre:
            return "genreCell"
        case .track:
            return "trackCell"
        }
    }
    
    var title: String {
        switch self {
        case .album:
            return R.string.localizable.albums()
        case .artist:
            return R.string.localizable.artists()
        case .genre:
            return R.string.localizable.genres()
        case .track:
            return R.string.localizable.tracks()
        }
    }
}

protocol Category: Codable {
    static var categoryType: CategoryType {get}
    
    static func browseComponent(parentItem: Category?) -> BrowseComponent!
    static func nextType() -> Category.Type?
    
    var title: String {get}
    var uri: String {get}
    var type: String {get}
    var albumArt: String {get}
    var service: String {get}
}
