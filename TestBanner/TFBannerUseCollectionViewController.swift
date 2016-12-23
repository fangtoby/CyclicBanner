//
//  TFBannerUseCollectionViewController.swift
//  TestBanner
//
//  Created by tiantengfei on 2016/12/22.
//  Copyright © 2016年 田腾飞. All rights reserved.
//

import UIKit

class TFBannerUseCollectionViewController: UIViewController {

    let images = ["0.png", "1.png", "2.png", "3.png"]
    var collectionView: UICollectionView!
    var pageView: UIPageControl!
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        automaticallyAdjustsScrollViewInsets = false
        
        do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight)
            flowLayout.estimatedItemSize = CGSize(width: kScreenWidth, height: kScreenHeight)
            
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: flowLayout)
            collectionView.register(TFBannerCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            view.addSubview(collectionView)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
        }
        
        do {
            pageView = UIPageControl(frame: CGRect(x: 0, y: kScreenHeight - 30, width: kScreenWidth, height: 30))
            view.addSubview(pageView)
            pageView.numberOfPages = images.count
            pageView.currentPage = 0
            pageView.pageIndicatorTintColor = UIColor.white
            pageView.currentPageIndicatorTintColor = UIColor.blue
        }
    }
    
    /// 添加timer
    func addTimer() {
        timer = Timer(timeInterval: 2, repeats: true, block: { [weak self] _ in
            self?.nextImage()
        })
        
        guard let timer = timer else {
            return
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 下一个图片
    func nextImage() {
        
    }
}

extension TFBannerUseCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TFBannerCollectionViewCell
        
        print(indexPath.row)
        if let cell = cell {
            cell.imageName = images[indexPath.item % 4]
            return cell
        }
        
        return cell!
    }
}

extension TFBannerUseCollectionViewController: UICollectionViewDelegate {
    
}
