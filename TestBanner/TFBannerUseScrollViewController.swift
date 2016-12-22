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
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTimer()
    }
    
    func setupViews() {
        do {
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            scrollView.delegate = self
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
            /// 只使用3个UIImageView，依次设置好最后一个，第一个，第二个图片，这里面使用取模运算。
            for index in 0..<3 {
                let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
                imageView.image = UIImage(named: "\((index + 3) % 4).png")
                scrollView.addSubview(imageView)
            }
        }
        
        do {
            scrollView.contentSize = CGSize(width: kScreenWidth * 3, height: 0)
            scrollView.contentOffset = CGPoint(x: kScreenWidth, y: 0)
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
        }
    }
    
    /// 添加timer
    func addTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] (timer) in
            self?.nextImage()
        })
    }
    
    /// 下一个图片
    func nextImage() {
        if pageView.currentPage == imageCount - 1 {
            pageView.currentPage = 0
        } else {
            pageView.currentPage += 1
        }
        let contentOffset = CGPoint(x: kScreenWidth * 2, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    /// 上一个图片
    func preImage() {
        if pageView.currentPage == 0 {
            pageView.currentPage = imageCount - 1
        } else {
            pageView.currentPage -= 1
        }
        
        let contentOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    /// 重新加载图片，重新设置3个imageView
    func reloadImage() {
        let currentIndex = pageView.currentPage
        let nextIndex = (currentIndex + 1) % 4
        let preIndex = (currentIndex + 3) % 4
        
        (scrollView.subviews[0] as! UIImageView).image = UIImage(named: "\(preIndex).png")
        (scrollView.subviews[1] as! UIImageView).image = UIImage(named: "\(currentIndex).png")
        (scrollView.subviews[2] as! UIImageView).image = UIImage(named: "\(nextIndex).png")
    }
}

extension TFBannerUseScrollViewController: UIScrollViewDelegate {
    
    /// 开始滑动的时候，停止timer，设置为niltimer才会销毁
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    /// 当停止滚动的时候重新设置三个ImageView的内容，然后悄悄滴显示中间那个imageView
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImage()
        scrollView.setContentOffset(CGPoint(x: kScreenWidth, y: 0), animated: false)
    }
    
    /// 停止拖拽，开始timer, 并且判断是显示上一个图片还是下一个图片
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
        
        if scrollView.contentOffset.x < kScreenWidth {
            preImage()
        } else {
            nextImage()
        }
    }
}
