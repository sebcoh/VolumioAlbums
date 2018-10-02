//
//  AlbumTracksViewController.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 29.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import UIKit

class AlbumTracksViewController: UITableViewController {
    var browseComponent: TrackBrowseComponent?
    var items: [Category]?
    
    private func refreshList() {
        browseComponent?.fetchItems(completion: { (items) in
            self.items = items
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return browseComponent!.cellFor(item: items![indexPath.row], tableView: tableView, indexPath: indexPath)!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 44
        }
    }
    
    
}
