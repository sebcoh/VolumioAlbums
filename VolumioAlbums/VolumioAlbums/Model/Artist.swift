//
//  Artist.swift
//  WStest
//
//  Created by Sebastian Cohausz on 12.08.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import Foundation
struct Artist: Category {
    static func browseComponent(parentItem: Category?) -> BrowseComponent! {
        return nil
    }
    
    
    
    let title: String
    let uri: String
    let type: String
    let albumArt: String
    let service: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case uri
        case type
        case albumArt = "albumart"
        case service
    }
    
    static var categoryType: CategoryType = .artist
}
