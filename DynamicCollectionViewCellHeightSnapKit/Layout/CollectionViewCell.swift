//
//  CollectionViewCell.swift
//  Layout
//
//  Created by Chris Hu on 16/11/28.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {

    var imageView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        commonInit()
    }

    func commonInit() {
        if imageView == nil {
            imageView = UIImageView(frame: bounds)
            imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
            
            imageView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(0)
                make.right.equalToSuperview().offset(0)
                make.bottom.equalToSuperview().offset(0)
                make.height.equalTo(frame.height)
            }
        }
        
        if label == nil {
            label = UILabel()
            label.text = "label"
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.backgroundColor = UIColor.red
            addSubview(label)
            
            label.snp.makeConstraints({ (make) in
                make.top.equalTo(imageView).offset(0)
                make.right.equalTo(imageView).offset(-5)
                make.width.equalTo(30)
                make.height.equalTo(20)
            })
        }
    }
    
    func updateHightImageView(_ height: CGFloat) {
        imageView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        updateConstraints()
    }
}
