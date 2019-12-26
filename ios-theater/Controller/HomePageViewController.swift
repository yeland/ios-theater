//
//  ViewController.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/17.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
  @IBOutlet weak var bannerCollectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var hotMoviesCollectionView: UICollectionView!
  
  private let moviesViewModel = MoviesViewModel()
  private let largeNumberForSections = 100
  private let images = ["banner1", "banner2", "banner3", "banner4", "banner5"]
  private let hotMoviesNumber = 6
  private var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()
    let middleInSections = largeNumberForSections/2
    bannerCollectionView.scrollToItem(at: IndexPath.init(row: 0, section: middleInSections), at: .centeredHorizontally, animated: true)
    navigationController?.navigationBar.isHidden = true
    bannerCollectionView.contentInsetAdjustmentBehavior = .never    
    pageControl.numberOfPages = images.count
    pageControl.currentPage = 0
    hotMoviesCollectionView.register(UINib(nibName: "MovieCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionCell")
    fetchData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    addTimer()
  }
  
  private func fetchData() {
    moviesViewModel.fetchHotMovies() {
      self.hotMoviesCollectionView.reloadData()
    }
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
    let indexPath = bannerCollectionView.indexPathsForVisibleItems.last
    guard let currentIndexPath = indexPath else { return }
    var nextItem = (currentIndexPath.item) + 1
    var nextSection = currentIndexPath.section
    if nextItem == images.count {
      nextItem = 0
      nextSection += 1
    }
    let nextIndexPath = IndexPath(item: nextItem, section: nextSection)
    bannerCollectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
  }
}

extension HomePageViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    if collectionView == self.bannerCollectionView {
      return largeNumberForSections
    }
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == self.bannerCollectionView {
      return images.count
    }
    return hotMoviesNumber > moviesViewModel.hotMovies.count ? moviesViewModel.hotMovies.count : hotMoviesNumber
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == self.bannerCollectionView {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
        fatalError("Can not create cell")
      }
      cell.configure(imageName: images[indexPath.item])
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as? MovieCollectionCell else {
        fatalError("Can not create cell")
      }
      cell.configure(movie: moviesViewModel.hotMovies[indexPath.item])
      return cell
    }
  }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == self.bannerCollectionView {
      return CGSize(width: view.bounds.width, height: collectionView.bounds.height)
    } else {
      return CGSize(width: 117, height: 240)
    }
  }
}

extension HomePageViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let visibleRect = CGRect(origin: self.bannerCollectionView.contentOffset, size: self.bannerCollectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    if let visibleIndexPath = self.bannerCollectionView.indexPathForItem(at: visiblePoint) {
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
