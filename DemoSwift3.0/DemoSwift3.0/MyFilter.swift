//
//  MyFilter.swift
//  DemoSwift3.0
//
//  Created by zj－db0465 on 16/11/17.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import GPUImage

class MyFilter: GPUImageFilterGroup {
    
    var lookupImageSource:GPUImagePicture!
    
//    required override init() {
//        super.init()
//        
//        let image:UIImage = UIImage(named: "LUT_Moonlight.png")!
//        self.lookupImageSource = GPUImagePicture(image: image)
//        let lookupFilter = GPUImageLookupFilter()
//        self.addFilter(lookupFilter)
//        self.lookupImageSource.addTarget(lookupFilter, atTextureLocation: 1)
//        lookupImageSource.processImage()
//        self.initialFilters = [lookupFilter]
//        self.terminalFilter = lookupFilter
//    }
    
    convenience init(LUTImage: UIImage!) {
        self.init()
        
        self.lookupImageSource = GPUImagePicture(image: LUTImage)
        let lookupFilter = GPUImageLookupFilter()
        self.addFilter(lookupFilter)
        self.lookupImageSource.addTarget(lookupFilter, atTextureLocation: 1)
        lookupImageSource.processImage()
        self.initialFilters = [lookupFilter]
        self.terminalFilter = lookupFilter
    }
    
}
