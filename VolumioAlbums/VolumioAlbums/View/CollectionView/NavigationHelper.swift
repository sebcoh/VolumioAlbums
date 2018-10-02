//
//  NavigationHelper.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 01.10.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import UIKit
struct NavigationHelper {
    static func viewControllerForParentItem(parentItem: Category) -> UIViewController? {
        if let parentItem = parentItem as? Album {
            if let vc = R.storyboard.main.albumTracksViewController() {
                vc.browseComponent = type(of: parentItem).nextType()?.browseComponent(parentItem: parentItem) as? TrackBrowseComponent
                vc.navigationItem.title = parentItem.title
                return vc
            }
        } else {
            if let vc = R.storyboard.main.browseViewController() {
                vc.browseComponent = type(of: parentItem).nextType()?.browseComponent(parentItem: parentItem)
                vc.navigationItem.title = parentItem.title
                return vc
            }
        }
        return nil
    }
}
