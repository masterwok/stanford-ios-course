//
//  CardView.swift
//  concentration
//
//  Created by Jonathan Trowbridge on 1/9/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet var contentView: CardView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        inflate()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        inflate()
    }

    private func inflate() {
        Bundle.main.loadNibNamed("CardViewNib", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = bounds
    }
}
