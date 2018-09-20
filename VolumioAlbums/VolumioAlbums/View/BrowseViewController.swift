//
//  BrowseViewController.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 23.07.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import UIKit
import RxSwift
import SocketIO

class BrowseViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var client = VolumioClient()
    
    var disposeBag = DisposeBag()
    
    var items: [Category] = []
    var categoryType: CategoryType!
    
    var component: BrowseComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.delegate = self
        self.collectionView?.setCollectionViewLayout(AlbumCoverFlowLayout(), animated: false)
        
        client.playBackState.asObservable().subscribe(onNext: { playbackstate in
            print("from Observer: \(playbackstate)")
        }).disposed(by: disposeBag)
    }
    
    func setup(parentItem: Category) {
        component = type(of: parentItem).browseComponent(parentItem: parentItem)
        component.fetchItems { (items) in
            self.items = items
            self.collectionView?.reloadData()
        }
    }
    
    func setup<T: Category>(type: T.Type) {
        component = T.browseComponent(parentItem: nil)
        component.fetchItems { (items) in
            self.items = items
            self.collectionView?.reloadData()
        }
    }
    
    func drillDown<T: Category, U: Category>(item: T, nextType: U.Type) {
        categoryType = U.categoryType
        client.drillDown(item: item).subscribe(onNext: { (items: [U]) in
            self.items = items
            self.collectionView?.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 4
        let height = width * 4 / 3
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return component.cellFor(item: items[indexPath.row], collectionView: collectionView, indexPath: indexPath)!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrowseViewController") as! BrowseViewController
        
        bvc.setup(parentItem: items[indexPath.row])    
        self.navigationController?.pushViewController(bvc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

