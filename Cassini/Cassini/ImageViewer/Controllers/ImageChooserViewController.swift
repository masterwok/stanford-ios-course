//
//  ImageChooserViewController.swift
//  Cassini
//
//  Created by Jonathan Trowbridge on 1/14/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class ImageChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    // Just hardcode PoC choices
    static let imageChoices: [String:String] = [
        "Earth": "https://www.wired.com/images_blogs/wiredscience/2012/02/eastern-earth-space-nasa.jpg",
        "Sun": "https://external-preview.redd.it/sZoihZXu3khZHwQE3XnsgqgsZ6xdKwhRw-Pg2Q7Z-Co.jpg?auto=webp&s=55dcda1e870fbc33202d3be57ba56ed534a134b8",
        "Saturn": "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA17172_hires.jpg",
    ]

    @IBAction func onImageButtonTouchUpInside(_ sender: UIButton) {
            performSegue(withIdentifier: "Show Image", sender: sender)
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController
        , collapseSecondary secondaryViewController: UIViewController
        , onto primaryViewController: UIViewController
    ) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        splitViewController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = (segue.destination as! UINavigationController).visibleViewController as! ImageViewController

        let label = (sender as! UIButton).titleLabel!.text!
        
        viewController.title = label
        viewController.imageUrl = URL(string: ImageChooserViewController.imageChoices[label]!)
    }

}
