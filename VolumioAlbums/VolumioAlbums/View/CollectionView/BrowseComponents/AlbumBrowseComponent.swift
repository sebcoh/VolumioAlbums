//
//  AlbumBrowseComponent.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 15.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

struct AlbumBrowseComponent: BrowseComponent {
    init(parentItem: Category?) {
        self.parentItem = parentItem
    }
    
    var parentItem: Category?
    var disposeBag: DisposeBag = DisposeBag()
    
    func fetchItems(completion: @escaping ([Category]) -> ()) {
        VolumioClient.shared.fetchCategoryItems(item: parentItem as? Artist).subscribe(onNext: { (items: [Album]) in
            completion(items)
        }).disposed(by: disposeBag)
    }
} 
