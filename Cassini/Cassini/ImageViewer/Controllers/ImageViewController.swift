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
            
            updateImage()
        }
    }
    
    private var imageView = UIImageView()
    private var requestWorkItem: DispatchWorkItem?

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imageView.image == nil {
            updateImage()
        }
    }
    
    private func updateImage() {
        spinner.startAnimating()
        
        // Cancel any previous work item
        requestWorkItem?.cancel()
        
        // Should hold weak self reference because controller may be nil if closure outlives the controller
        // Don't need a weak reference due to circular reference because self does not hold a reference to
        // the closure.
        requestWorkItem = DispatchWorkItem { [weak self] in
            let fetchedImage = self?.fetchImage()
            
            DispatchQueue.main.async {
                self?.image = fetchedImage
            }
        }

        // Dispatch work item to queue
        DispatchQueue.global(qos: .userInitiated).async(execute: requestWorkItem!)
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
            self.spinner.stopAnimating()
        }
    }
    
    private func fetchImage() -> UIImage? {
        let url = imageUrl
        
        if url == nil {
            return nil
        }
        
        // Try and return nil if an error occurs
        let urlContents = try? Data(contentsOf: imageUrl!)

        if let imageData = urlContents
            // Don't return image if url changed during request
            , url == imageUrl {
            return UIImage(data: imageData)
        }
        
        return nil
    }
    
}
