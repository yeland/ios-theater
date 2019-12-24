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
  
  private let largeNumberForSections = 100
  private let images = ["banner1", "banner2", "banner3", "banner4", "banner5"]
  private var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()
    let middleInSections = largeNumberForSections/2
    collectionView.scrollToItem(at: IndexPath.init(row: 0, section: middleInSections), at: .centeredHorizontally, animated: true)
    navigationController?.navigationBar.isHidden = true
    collectionView.contentInsetAdjustmentBehavior = .never    
    pageControl.numberOfPages = images.count
    pageControl.currentPage = 0
  }
  
  override func viewDidAppear(_ animated: Bool) {
    addTimer()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    removeTimer()
  }
  
  private func addTimer() {
    timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.autoSwitch), userInfo: nil, repeats: true)
  }
  
  private func removeTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  @objc private func autoSwitch() {
    let indexPath = collectionView.indexPathsForVisibleItems.last
    guard let currentIndexPath = indexPath else { return }
    var nextItem = (currentIndexPath.item) + 1
    var nextSection = currentIndexPath.section
    if nextItem == images.count {
      nextItem = 0
      nextSection += 1
    }
    let nextIndexPath = IndexPath(item: nextItem, section: nextSection)
    collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
  }
}

extension HomePageViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return largeNumberForSections
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
      fatalError("Can not create cell")
    }
    cell.configure(imageName: images[indexPath.item])
    return cell
  }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.bounds.width, height: collectionView.bounds.height)
  }
}

extension HomePageViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
      self.pageControl.currentPage = visibleIndexPath.row
    }
  }
  
  func scrollViewWillBeginDragging (_ scrollView: UIScrollView) {
    removeTimer()
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    addTimer()
  }
}
