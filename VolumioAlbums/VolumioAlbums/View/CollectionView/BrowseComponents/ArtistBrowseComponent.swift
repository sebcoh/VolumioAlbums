//
//  ArtistBrowseComponent.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 15.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

struct ArtistBrowseComponent: BrowseComponent {
    init(parentItem: Category?) {
        self.parentItem = parentItem
    }
    
    var parentItem: Category?
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func fetchItems(completion: @escaping ([Category]) -> ()) {
        VolumioClient.shared.fetchCategoryItems(item: parentItem as? Artist).subscribe(onNext: { (items: [Artist]) in
            completion(items)
        }).disposed(by: disposeBag)
    }
    
    /**
     Return a cell for the given item. Returns nil if the item does not conform to Album.
     
     - parameter item: Model item to use to fill the cell
     - parameter collectionView: CollectionView this cell is for / from
     - parameter indexPath: IndexPath, required for the collection view
     */
    func cellFor(item: Category, collectionView: UICollectionView, indexPath: IndexPath) -> BaseCollectionViewCell? {
        guard let item = item as? Artist else {return nil}
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Album.categoryType.collectionCellId, for: indexPath) as! AlbumCoverCollectionViewCell
        cell.artistLabel.text = item.title
        cell.albumLabel.text = nil
        cell.albumArt.image = nil
        cell.albumArtURL = URL(string: VolumioClient.shared.baseURL.absoluteURL.absoluteString + item.albumArt)
        
        return cell
    }
} 
