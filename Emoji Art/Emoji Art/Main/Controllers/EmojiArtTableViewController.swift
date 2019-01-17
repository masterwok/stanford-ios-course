//
//  EmojiArtTableViewController.swift
//  Emoji Art
//
//  Created by Jonathan Trowbridge on 1/17/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class EmojiArtTableViewController: UITableViewController {
    
    private var emojiArtDocuments = ["One", "Two", "Three"]

    @IBAction func barButtonAddDocumentOnTouchUpInside(_ sender: UIBarButtonItem) {
        emojiArtDocuments = "Untitled".ensureUnique(forItems: emojiArtDocuments)
        
        let indexPath = IndexPath(item: emojiArtDocuments.count - 1, section: 0)
        
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiArtDocuments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)

        cell.textLabel?.text = emojiArtDocuments[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
