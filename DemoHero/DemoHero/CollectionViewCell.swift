//
//  CollectionViewCell.swift
//  DemoHero
//
//  Created by Chris Hu on 17/1/5.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
