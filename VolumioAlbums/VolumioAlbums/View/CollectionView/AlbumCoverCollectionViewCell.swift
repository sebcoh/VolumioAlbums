    //
//  AlbumCoverCollectionViewCell.swift
//  WStest
//
//  Created by Sebastian Cohausz on 26.07.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import UIKit
class AlbumCoverCollectionViewCell: BaseCollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
            if (self.isHighlighted) {
                self.alpha = 0.5
            } else {
                self.alpha = 1.0
            }
        }
    }
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var albumArt: UIImageView!
    
    var albumArtURL: URL? {
        didSet {
            DispatchQueue.global().async { [weak self, theUrl = albumArtURL] in
                let image: UIImage?
                do {
                    image = UIImage(data: try Data(contentsOf: (self?.albumArtURL)!))
                    DispatchQueue.main.async {
                        if (self?.albumArtURL == theUrl) {
                            self?.albumArt?.image = image
                        }
                    }
                } catch {
                    print("Error: data for \(String(describing: self?.albumArtURL?.absoluteString)) could not be fetched: \(error)")
                }
                
            }
        }
    }
}
