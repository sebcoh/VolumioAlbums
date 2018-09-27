//
//  TrackBrowseComponent.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 27.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import Foundation
import RxSwift

struct TrackBrowseComponent: BrowseComponent {
    init(parentItem: Category?) {
        self.parentItem = parentItem
    }
    
    var parentItem: Category?
    var disposeBag: DisposeBag = DisposeBag()
    
    func fetchItems(completion: @escaping ([Category]) -> ()) {
        VolumioClient.shared.fetchCategoryItems(item: parentItem as? Album).subscribe(onNext: { (items: [Track]) in
            completion(items)
        }).disposed(by: disposeBag)
    }
}
