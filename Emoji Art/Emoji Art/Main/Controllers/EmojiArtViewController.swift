//
//  EmojiArtViewController.swift
//  Emoji Art
//
//  Created by Jonathan Trowbridge on 1/15/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

    @IBOutlet weak var viewDropZone: UIView!{
        didSet {
            viewDropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    @IBOutlet weak var viewEmojiArt: EmojiArtView!
    
    func dropInteraction(
        _ interaction: UIDropInteraction
        , canHandle session: UIDropSession
    ) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self)
            && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(
        _ interaction: UIDropInteraction
        , sessionDidUpdate session: UIDropSession
    ) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(
        _ interaction: UIDropInteraction
        , performDrop session: UIDropSession
    ) {
        session.loadObjects(ofClass: NSURL.self) { urls in
            if let url = urls.first as? URL {
                ImageFetcher.fetch(url: url) { (url, image) in
                    self.viewEmojiArt.backgroundImage = image
                }
            }
        }
        
        session.loadObjects(ofClass: UIImage.self) { images in
            if let image = images.first as? UIImage {
                self.viewEmojiArt.backgroundImage = image
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
