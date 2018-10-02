//
//  AlbumTracksHeaderCell.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 29.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import UIKit
class AlbumTracksHeaderCell: UITableViewCell {
    
    @IBOutlet weak var albumArtView: UIImageView!
    @IBOutlet weak var albumArtBackgroundView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    var albumArtURL: URL? {
        didSet {
            DispatchQueue.global().async { [weak self, theUrl = albumArtURL] in
                let image: UIImage?
                do {
                    image = UIImage(data: try Data(contentsOf: (self?.albumArtURL)!))
                    DispatchQueue.main.async {
                        if (self?.albumArtURL == theUrl) {
                            self?.albumArtView?.image = image
                            self?.albumArtBackgroundView?.image = image
                        }
                    }
                } catch {
                    print("Error: data for \(String(describing: self?.albumArtURL?.absoluteString)) could not be fetched: \(error)")
                }
                
            }
        }
    }
}
