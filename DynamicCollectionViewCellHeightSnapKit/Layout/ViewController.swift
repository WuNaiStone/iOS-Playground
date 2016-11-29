//
//  ViewController.swift
//  Layout
//
//  Created by Chris Hu on 16/11/28.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    
    var photoRatioArray = [CGFloat]() // height/width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "CollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in 0...31 {
            let image = UIImage(named: "\(i).jpg")
            photoRatioArray.append((image?.size.height)! / (image?.size.width)!)
        }
        
        let lineCount = photoRatioArray.count / 3
        for i in 0..<lineCount {
            let finalRatio = max(photoRatioArray[3*i], photoRatioArray[3*i+1], photoRatioArray[3*i+2])
            photoRatioArray[3*i] = finalRatio
            photoRatioArray[3*i+1] = finalRatio
            photoRatioArray[3*i+2] = finalRatio
        }
        
        let others = photoRatioArray.count % 3
        if others == 2 {
            let finalRatio = max(photoRatioArray[3*lineCount], photoRatioArray[3*lineCount+1])
            photoRatioArray[3*lineCount] = finalRatio
            photoRatioArray[3*lineCount+1] = finalRatio
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoRatioArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let image = UIImage(named: "\(indexPath.item).jpg")!
        cell.imageView.image = image
        cell.label.text = "\(indexPath.item + 1)"
        
        let height = image.size.height / image.size.width * cell.frame.width
        cell.updateHightImageView(height)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

}

// cell之间的间隔
fileprivate let kCellOffset         = CGFloat(10)
// 一行几个cell
fileprivate let kCellCountOfALine   = CGFloat(3)

extension ViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tmp = Int(view.frame.width - kCellOffset * (kCellCountOfALine - 1)) % Int(kCellCountOfALine)
        let width = (view.frame.width - kCellOffset * (kCellCountOfALine - 1) - CGFloat(tmp)) / kCellCountOfALine
        
        let photoRatio = photoRatioArray[indexPath.item]
        let height = photoRatio * width
        return CGSize(width: width, height: CGFloat(height))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: kCellOffset, left: 0, bottom: kCellOffset, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kCellOffset
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let tmp = Int(view.frame.width - kCellOffset * (kCellCountOfALine - 1)) % Int(kCellCountOfALine)
        let width = (view.frame.width - kCellOffset * (kCellCountOfALine - 1) - CGFloat(tmp)) / kCellCountOfALine
        let offset = (view.frame.width - width * kCellCountOfALine) / (kCellCountOfALine - 1)
        return offset
    }
}


