//
//  PlaybackControlsCell.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 02.10.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import UIKit

protocol PlaybackControlsDelegate: class {
    func startBrowsing<T: Category>(type: T.Type)
}

class PlaybackControlsCell: UITableViewCell {
    
    weak var delegate: PlaybackControlsDelegate?
    
    @IBAction func albumsTapped(_ sender: UIBarButtonItem) {
        delegate?.startBrowsing(type: Album.self)
    }
    
    @IBAction func artistsTapped(_ sender: UIBarButtonItem) {
        delegate?.startBrowsing(type: Artist.self)
    }
    
    @IBAction func genresTapped(_ sender: UIBarButtonItem) {
        delegate?.startBrowsing(type: Genre.self)
    }
}
