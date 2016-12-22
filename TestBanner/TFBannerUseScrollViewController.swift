//
//  TFBannerUseScrollViewController.swift
//  TestBanner
//
//  Created by tiantengfei on 2016/12/22.
//  Copyright © 2016年 田腾飞. All rights reserved.
//

import UIKit

class TFBannerUseScrollViewController: UIViewController {

    let imageCount = 4
    var scrollView: UIScrollView!
    var pageView: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        do {
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            view.addSubview(scrollView)
        }
        
        do {
            pageView = UIPageControl(frame: CGRect(x: 0, y: kScreenHeight - 30, width: kScreenWidth, height: 30))
            view.addSubview(pageView)
            pageView.numberOfPages = imageCount
            pageView.currentPage = 0
            pageView.pageIndicatorTintColor = UIColor.white
            pageView.currentPageIndicatorTintColor = UIColor.blue
        }
        
        do {
            for index in 0..<imageCount {
                let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
                imageView.image = UIImage(named: "\(index + 1).png")
                scrollView.addSubview(imageView)
            }
        }
        
        do {
            scrollView.contentSize = CGSize(width: kScreenWidth * CGFloat(scrollView.subviews.count), height: 0)
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
        }
    }
}
