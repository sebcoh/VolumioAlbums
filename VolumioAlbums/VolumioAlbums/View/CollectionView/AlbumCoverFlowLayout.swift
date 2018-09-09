//
//  AlbumCoverFlowLayout.swift
//  WStest
//
//  Created by Sebastian Cohausz on 26.07.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import Foundation
import UIKit

class AlbumCoverFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumLineSpacing = 10.0
        self.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
