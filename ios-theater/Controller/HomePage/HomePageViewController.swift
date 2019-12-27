//
//  ViewController.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/17.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, HomePageViewControllerDelegate {
  @IBOutlet weak var bannerCollectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var hotMoviesCollectionView: UICollectionView!
  @IBOutlet weak var allButton: UIButton!
  
  private var bannerCollectionViewDatasourse: BannerCollectionViewDatasourse?
  private var bannerCollectionViewDelegate: BannerCollectionViewDelegate?
  private var hotMoviesCollectionViewDatasourse: HotMoviesCollectionViewDatasourse?
  private var hotMoviesCollectionViewDelegate: HotMoviesCollectionViewDelegate?
  
  private let moviesViewModel = MoviesViewModel()
  private let largeNumberForSections = 100
  private let images = ["banner1", "banner2", "banner3", "banner4", "banner5"]
  private var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupDatasourseAndDelegate()
    let middleInSections = largeNumberForSections/2
    bannerCollectionView.scrollToItem(at: IndexPath.init(row: 0, section: middleInSections), at: .centeredHorizontally, animated: true)
    navigationController?.navigationBar.isHidden = true 
    pageControl.numberOfPages = images.count
    pageControl.currentPage = 0
    hotMoviesCollectionView.register(UINib(nibName: "MovieCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionCell")
    fetchData()
  }
  
  func setupDatasourseAndDelegate() {
    bannerCollectionViewDatasourse = BannerCollectionViewDatasourse(imageNames: images, number: largeNumberForSections)
    let bannerCellSize = CGSize(width: view.bounds.width, height: self.bannerCollectionView.bounds.height)
    bannerCollectionViewDelegate = BannerCollectionViewDelegate(size: bannerCellSize, delegate: self)
    bannerCollectionView.dataSource = bannerCollectionViewDatasourse
    bannerCollectionView.delegate = bannerCollectionViewDelegate
    
    hotMoviesCollectionViewDatasourse = HotMoviesCollectionViewDatasourse()
    hotMoviesCollectionViewDelegate = HotMoviesCollectionViewDelegate()
    hotMoviesCollectionView.dataSource = hotMoviesCollectionViewDatasourse
    hotMoviesCollectionView.delegate = hotMoviesCollectionViewDelegate
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    addTimer()
  }
  
  private func fetchData() {
    moviesViewModel.fetchHotMovies() {
      self.hotMoviesCollectionViewDatasourse?.setHotMovies(withHotMovies: self.moviesViewModel.hotMovies)
      self.allButton.setTitle("全部\(self.moviesViewModel.total)", for: .normal)
      self.hotMoviesCollectionView.reloadData()
    }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    removeTimer()
  }
  
  internal func setCurrentPage() {
    let visibleRect = CGRect(origin: self.bannerCollectionView.contentOffset, size: self.bannerCollectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    if let visibleIndexPath = self.bannerCollectionView.indexPathForItem(at: visiblePoint) {
      self.pageControl.currentPage = visibleIndexPath.row
    }
  }
  
  internal func addTimer() {
    timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.autoSwitch), userInfo: nil, repeats: true)
  }
  
  internal func removeTimer() {
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
