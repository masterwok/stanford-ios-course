//
//  ImageFetcher.swift
//  Emoji Art
//
//  Created by Jonathan Trowbridge on 1/15/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation
import UIKit

class ImageFetcher {
    
    private init() {
    }
    
    private static var workItem: DispatchWorkItem?
    
    static func fetch(
        url: URL
        , onResult: @escaping (URL, UIImage?) -> ()
    ) {
        workItem?.cancel()
        
        workItem = DispatchWorkItem {
            let data = try? Data(contentsOf: url)
            
            // Request failed for some reason return nil
            if (data == nil) {
                onResult(url, nil)
                return
            }
            
            onResult(url, UIImage(data: data!))
        }

        DispatchQueue.global(qos: .userInitiated).async(execute: workItem!)
    }

}
