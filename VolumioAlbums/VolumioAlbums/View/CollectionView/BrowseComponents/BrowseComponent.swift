//
//  BrowseComponent.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 12.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import Foundation
import UIKit

protocol BrowseComponent {
    
    init(parentItem: Category?)
    func fetchItems(completion: @escaping ([Category]) -> ())
    func cellFor(item: Category, collectionView: UICollectionView, indexPath: IndexPath) -> BaseCollectionViewCell?
}

extension BrowseComponent {
    /**
     Return a cell for the given item. Returns nil if the item does not conform to Album.
     
     - parameter item: Model item to use to fill the cell
     - parameter collectionView: CollectionView this cell is for / from
     - parameter indexPath: IndexPath, required for the collection view
     */
    func cellFor(item: Category, collectionView: UICollectionView, indexPath: IndexPath) -> BaseCollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Genre.categoryType.collectionCellId, for: indexPath) as! AlbumCoverCollectionViewCell
        cell.artistLabel.text = item.title
        cell.albumLabel.text = nil
        cell.albumArt.image = nil
        cell.albumArtURL = URL(string: VolumioClient.shared.baseURL.absoluteURL.absoluteString + item.albumArt)
        
        return cell
    }
}
