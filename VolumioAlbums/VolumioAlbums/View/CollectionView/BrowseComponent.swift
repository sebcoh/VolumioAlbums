//
//  BrowseComponent.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 12.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol BrowseComponent {
    init(parentItem: Category?)
    func fetchItems(completion: @escaping ([Category]) -> ())
    func cellFor(item: Category, collectionView: UICollectionView, indexPath: IndexPath) -> BaseCollectionViewCell?
}

struct AlbumBrowseComponent: BrowseComponent {
    init(parentItem: Category?) {
        self.parentItem = parentItem
    }
    
    var parentItem: Category?
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func fetchItems(completion: @escaping ([Category]) -> ()) {
        VolumioClient.shared.fetchCategoryItems(item: parentItem as? Album).subscribe(onNext: { (items: [Album]) in
            completion(items)
        }).disposed(by: disposeBag)
    }
    
    /**
     Return a cell for the given item. Returns nil if the item does not conform to BrowseCategory.
     
     - parameter item: Model item to use to fill the cell
     - parameter collectionView: CollectionView this cell is for / from
     - parameter indexPath: IndexPath, required for the collection view
     */
    func cellFor(item: Category, collectionView: UICollectionView, indexPath: IndexPath) -> BaseCollectionViewCell? {
        guard let item = item as? Album else {return nil}
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Album.categoryType.collectionCellId, for: indexPath) as! AlbumCoverCollectionViewCell
        cell.artistLabel.text = item.artist
        cell.albumLabel.text = item.title
        cell.albumArt.image = nil
        cell.albumArtURL = URL(string: VolumioClient.shared.baseURL.absoluteURL.absoluteString + item.albumArt)
        
        return cell
    }
} 
