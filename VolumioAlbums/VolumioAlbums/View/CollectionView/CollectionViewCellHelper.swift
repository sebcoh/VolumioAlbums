//
//  CollectionViewCellHelper.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 10.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCellHelper {
    class func cellFor(item: Category, collectionView: UICollectionView, indexPath: IndexPath) -> BaseCollectionViewCell! {
        if let item = item as? Album {
            return albumCell(item: item, collectionView: collectionView, indexPath: indexPath)
        } else if let item = item as? Artist {
            return artistCell(item: item, collectionView: collectionView, indexPath: indexPath)
        }
        
        return nil
    }
    
    static func albumCell(item: Album, collectionView: UICollectionView, indexPath: IndexPath) -> AlbumCoverCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Album.categoryType.collectionCellId, for: indexPath) as! AlbumCoverCollectionViewCell
        cell.artistLabel.text = item.artist
        cell.albumLabel.text = item.title
        cell.albumArt.image = nil
        cell.albumArtURL = URL(string: VolumioClient.shared.baseURL.absoluteURL.absoluteString + item.albumArt)
        
        return cell
    }
    
    static func artistCell(item: Artist, collectionView: UICollectionView, indexPath: IndexPath) -> AlbumCoverCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Album.categoryType.collectionCellId, for: indexPath) as! AlbumCoverCollectionViewCell
        cell.artistLabel.text = item.title
        cell.albumArt.image = nil
        cell.albumArtURL = URL(string: VolumioClient.shared.baseURL.absoluteURL.absoluteString + item.albumArt)
        
        return cell
    }
}
