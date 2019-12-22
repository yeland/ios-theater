//
//  ViewController.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/17.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  
  let images = ["banner1", "banner2", "banner3", "banner4", "banner5"]

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    navigationController?.navigationBar.isHidden = true
    collectionView.contentInsetAdjustmentBehavior = .never    
    pageControl.numberOfPages = images.count
    pageControl.currentPage = 0
  }
}

extension HomePageViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
      fatalError("Can not create cell")
    }
    cell.configure(image: images[indexPath.item])
    return cell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
      self.pageControl.currentPage = visibleIndexPath.row
    }
  }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.bounds.width, height: collectionView.bounds.height)
  }
}



