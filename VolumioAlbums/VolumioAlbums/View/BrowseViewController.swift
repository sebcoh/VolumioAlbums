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
    var artists: [Artist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.delegate = self
        self.collectionView?.setCollectionViewLayout(AlbumCoverFlowLayout(), animated: false)
        
        client.playBackState.asObservable().subscribe(onNext: { playbackstate in
            print("from Observer: \(playbackstate)")
        }).disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup<T: Category>(type: T.Type) {
        client.fetchCategoryItems().subscribe(onNext: { (items: [T]) in
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) as! AlbumCoverCollectionViewCell
        let item = items[indexPath.row]
        cell.artistLabel.text = item.title
        cell.albumLabel.text = item.title
        cell.albumArt.image = nil
        
        let url2 = URL(string: client.baseURL.absoluteURL.absoluteString + item.albumArt)
        //let url = client.baseURL.absoluteURL.appendingPathExtension()
        cell.albumArtURL = url2
        
//        let item = artists[indexPath.row]
//        cell.artistLabel.text = item.title
//        cell.albumLabel.text = nil
        
        cell.albumArtURL = URL(string: client.baseURL.absoluteURL.absoluteString + item.albumArt)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //probably create a method for requests and viewcontrollers of a type?
        //when drilling down, just use the contained uri, and the drilldown type ..
        /*
         let item = items[indexPath.row]
         let obs: Observable<item.categoryType> = client.fetchCategoryItems()
            self.items = artists
            self.collectionView?.reloadData()
        }).disposed(by: disposeBag)*/
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

