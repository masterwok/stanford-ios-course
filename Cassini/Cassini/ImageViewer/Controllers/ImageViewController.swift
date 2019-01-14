//
//  ImageViewController.swift
//  Cassini
//
//  Created by Jonathan Trowbridge on 1/14/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageUrl: URL? {
        didSet {
            imageView.image = nil

            // Don't fetch the image if we're not on screen
            if view.window == nil {
                return
            }
            
            image = fetchImage()
        }
    }
    
    private var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.5
            scrollView.delegate = self
            
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imageUrl == nil {
            imageUrl = URL(string: "https://solarsystem.nasa.gov/system/downloadable_items/2570_PIA21888.tif")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imageView.image == nil {
            image = fetchImage()
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    private func fetchImage() -> UIImage? {
        if imageUrl == nil {
            return nil
        }
        
        // Try and return nil if an error occurs
        let urlContents = try? Data(contentsOf: imageUrl!)
        
        if let imageData = urlContents {
            return UIImage(data: imageData)
        }
        
        return nil
    }
    
}
