//
//  ThemeChooserViewController.swift
//  concentration
//
//  Created by Jonathan Trowbridge on 1/11/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    private var splitViewDetailConcentrationController: ConcentraionViewController? {
        return splitViewController?.viewControllers.last as? ConcentraionViewController
    }
    
    @IBAction func chooseTheme(_ sender: Any) {
        if let cardViewController = splitViewDetailConcentrationController {
            let themeName = getThemeByName(name: (sender as? UIButton)?.currentTitle)
            
            // This will still reset the game due to this implementation using the emojis
            // themselves as the unique identifier.
            cardViewController.theme = themeName
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController
        , collapseSecondary secondaryViewController: UIViewController
        , onto primaryViewController: UIViewController
    ) -> Bool {
        // Show theme selector when theme is default
        if let cvc = secondaryViewController as? ConcentraionViewController {
            return cvc.theme == Theme.Default
        }
        
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func getThemeByName(name: String?) -> String {
        switch name {
        case "Sports": return Theme.Sports
        case "Faces": return Theme.Faces
        case "Animals": return Theme.Animals
        default: return Theme.Default
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewConroller = segue.destination as? ConcentraionViewController
        let text = (sender as? UIButton)?.titleLabel?.text
        
        viewConroller?.theme = getThemeByName(name: text)
    }
    
    override func shouldPerformSegue(
        withIdentifier identifier: String
        , sender: Any?
    ) -> Bool {
        return identifier == "Choose Theme"
    }

}
