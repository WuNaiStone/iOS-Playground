//
//  CollectionViewCell.swift
//  Layout
//
//  Created by Chris Hu on 16/11/28.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var heightImageView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
