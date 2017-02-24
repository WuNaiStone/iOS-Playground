//
//  ViewController.swift
//  DemoHero
//
//  Created by Chris Hu on 17/1/4.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import Kingfisher

let urlString = "http://oe5b5o4wx.bkt.clouddn.com/0de5fc94d0ba53fc7a44f0f136e82fbb/5E318D27-2536-43E5-8CF4-F72E6338FFA8"

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var collectionView: UICollectionView!
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: urlString)
        ImagePrefetcher(resources: [url!]).start()
        
        initCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let url = URL(string: urlString)
//        self.imageView.kf.setImage(with: url)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    func gotoAViewController() {
        
    }
}

extension ViewController {
    func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height - 160, width: view.frame.width, height: 160), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
//        cell.imageView.image = UIImage(named: "Model.jpg")
        let url = URL(string: urlString)
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.imageView.heroID = "hero-\(indexPath.item)"
        cell.blurView.heroID = "blurView"
        
        let aVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AViewController") as! AViewController
        aVC.indexPath = indexPath
        aVC.blurViewHeroID = "blurView"
        present(aVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height / 16 * 9, height: height)
    }
    
}



