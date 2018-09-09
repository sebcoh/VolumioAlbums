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
    }
    
    @IBAction func artistsTapped(_ sender: Any) {
        
        
        
        let bvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrowseViewController") as! BrowseViewController
        bvc.setup(type: Artist.self)
        self.present(bvc, animated: true, completion: nil)
        
    }
    
    @IBAction func albumsTapped(_ sender: Any) {
    }
}

