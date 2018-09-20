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
