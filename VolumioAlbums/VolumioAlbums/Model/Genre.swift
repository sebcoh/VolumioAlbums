//
//  Genre.swift
//  WStest
//
//  Created by Sebastian Cohausz on 12.08.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import Foundation
struct Genre: Category {
    static func browseComponent(parentItem: Category?) -> BrowseComponent! {
        return GenreBrowseComponent(parentItem: parentItem)
    }
    
    static func nextType() -> Category.Type? {
        return Artist.self
    }
    
    let title: String
    let uri: String
    let type: String
    let albumArt: String
    let service: String
    
    enum CodingKeys: String, CodingKey {
        case albumArt = "albumart"
        case service
        case title
        case type
        case uri
    }
    
    static var categoryType: CategoryType = .genre
   
}
