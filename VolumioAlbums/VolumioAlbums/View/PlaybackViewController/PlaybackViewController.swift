//
//  PlaybackViewController.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 02.10.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import UIKit
class PlaybackViewController: UITableViewController {
    struct TableViewConfig {
        
        let reuseIdentifier: String
         
    }
    
    var cellConfigs = [TableViewConfig(reuseIdentifier: R.reuseIdentifier.imageViewCell.identifier), 
        TableViewConfig(reuseIdentifier: R.reuseIdentifier.informationCell.identifier),
        TableViewConfig(reuseIdentifier: R.reuseIdentifier.controlsCell.identifier),
        TableViewConfig(reuseIdentifier: R.reuseIdentifier.playbackTrackCell.identifier),
        TableViewConfig(reuseIdentifier: R.reuseIdentifier.playbackTrackCell.identifier),
        TableViewConfig(reuseIdentifier: R.reuseIdentifier.playbackTrackCell.identifier),
        TableViewConfig(reuseIdentifier: R.reuseIdentifier.playbackTrackCell.identifier),
        TableViewConfig(reuseIdentifier: R.reuseIdentifier.playbackTrackCell.identifier),
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "whaa"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellConfigs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConfigs[indexPath.row].reuseIdentifier)!
     
        customizeCell(cell: cell)
        
        return cell
    }
    
    private func customizeCell(cell: UITableViewCell) {
        if let cell = cell as? PlaybackControlsCell {
            cell.delegate = self
        }
    }
}

extension PlaybackViewController: PlaybackControlsDelegate {
    func startBrowsing<T>(type: T.Type) where T : Category {
        let bvc = R.storyboard.main.browseViewController()!
        bvc.setup(type: T.self)
        let navCon = UINavigationController(rootViewController: bvc)
        self.present(navCon, animated: true, completion: nil)
    }
}
