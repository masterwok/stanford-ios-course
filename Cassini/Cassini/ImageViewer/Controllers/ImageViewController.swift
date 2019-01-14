//
//  ImageViewController.swift
//  Cassini
//
//  Created by Jonathan Trowbridge on 1/14/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageUrl: URL? {
        didSet {
            imageView.image = nil
            
            // Don't fetch the image if we're not on screen
            if view.window == nil {
                return
            }
            
            fetchImage()
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imageUrl == nil {
            imageUrl = URL(string: "https://solarsystem.nasa.gov/system/downloadable_items/2570_PIA21888.tif")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if imageUrl == nil {
            return
        }
        
        // Try and return nil if an error occurs
        let urlContents = try? Data(contentsOf: imageUrl!)
        
        if let imageData = urlContents {
            imageView.image = UIImage(data: imageData)
        }
    }
    
}
