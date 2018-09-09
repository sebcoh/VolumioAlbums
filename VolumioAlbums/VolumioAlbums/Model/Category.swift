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
    
    var request: String {
        switch self {
        case .album:
            return "albums://"
        case .artist:
            return "artists://"
        case .genre:
            return "genres://"
        }
    }
    
    var next: CategoryType? {
        switch self {
        case .album:
            return nil
        case .artist:
            return .album
        case .genre:
            return .artist
        }
    }
}

protocol Category: Codable {
    static var categoryType: CategoryType {get}
    
    var title: String {get}
    var uri: String {get}
    var type: String {get}
    var albumArt: String {get}
    var service: String {get}
}
