//
//  ThemeChooserViewController.swift
//  concentration
//
//  Created by Jonathan Trowbridge on 1/11/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    
    private struct Theme {
        static let Sports = "🏊‍♀️🚴🏻‍♂️🧗🏻‍♂️🤾🏻‍♀️🤽🏻‍♀️🤺🏄🏻‍♀️⛹🏻‍♂️"
        static let Faces = "😍🥰🤩🤪🧐🥳🤓😭"
        static let Animals = "🦞🦜🦚🦢🦘🦛🦝🦙"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewConroller = segue.destination as? ConcentraionViewController
        let text = (sender as? UIButton)?.titleLabel?.text
        
        switch text {
        case "Sports": viewConroller?.theme = Theme.Sports
        case "Faces": viewConroller?.theme = Theme.Faces
        case "Animals": viewConroller?.theme = Theme.Animals
        default: break
        }
    }
    
    override func shouldPerformSegue(
        withIdentifier identifier: String
        , sender: Any?
    ) -> Bool {
        return identifier == "Choose Theme"
    }

}
