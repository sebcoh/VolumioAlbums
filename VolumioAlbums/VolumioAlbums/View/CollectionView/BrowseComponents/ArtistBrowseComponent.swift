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
        VolumioClient.shared.fetchCategoryItems(item: parentItem as? Genre).subscribe(onNext: { (items: [Artist]) in
            completion(items)
        }).disposed(by: disposeBag)
    }
    func cellFor(item: Category, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
} 
