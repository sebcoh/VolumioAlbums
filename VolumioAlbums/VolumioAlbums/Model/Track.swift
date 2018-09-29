//
//  File.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 25.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import Foundation
struct Track: Category {
    static var categoryType: CategoryType = .track
    
    static func browseComponent(parentItem: Category?) -> BrowseComponent! {
        return TrackBrowseComponent(parentItem: parentItem)
    }
    
    static func nextType() -> Category.Type? {
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case uri
        case type
        case service
        case duration
        case trackType
        case trackNumber = "tracknumber"
    }
    
    var type: String
    
    var albumArt: String = ""
    
    var service: String
    
    let duration: Int
    let title: String
    let trackType: String
    let trackNumber: Int
    let uri: String
    
    
}
