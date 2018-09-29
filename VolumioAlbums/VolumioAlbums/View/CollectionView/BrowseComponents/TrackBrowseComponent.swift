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
            guard let parentItem = self.parentItem else {
                //famous last words: this should never happen
                completion([])
                return
            }
            
            let result = [parentItem]+(items as [Category])
            completion(result)
        }).disposed(by: disposeBag)
    }
    func cellFor(item: Category, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        if indexPath.row == 0 {
            return headerCellFor(tableView: tableView)
        }
        return UITableViewCell()
    }
    
    func cellFor(item: Category, collectionView: UICollectionView, indexPath: IndexPath) -> BaseCollectionViewCell? {
        return nil
    }
    
    private func headerCellFor(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.headerCell, for: IndexPath.init(item: 0, section: 0))
        cell?.artistLabel.text = (parentItem as? Track)?.artist
        cell?.albumTitleLabel.text = (parentItem as? Track)?.album 
        return cell!
    }
}
