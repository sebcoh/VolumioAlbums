//
//  ViewController.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 08.09.18.
//  Copyright © 2018 Sebastian Cohausz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func genresTapped(_ sender: Any) {
        self.pushViewController(type: Genre.self)
    }
    
    @IBAction func artistsTapped(_ sender: Any) {
        self.pushViewController(type: Artist.self)
    }
    
    @IBAction func albumsTapped(_ sender: Any) {
        self.pushViewController(type: Album.self)
    }
    
    private func pushViewController<T: Category>(type: T.Type) {
        let bvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrowseViewController") as! BrowseViewController
        bvc.setup(type: T.self, item: nil)
        let navCon = UINavigationController(rootViewController: bvc)
        self.present(navCon, animated: true, completion: nil)
    }
}

