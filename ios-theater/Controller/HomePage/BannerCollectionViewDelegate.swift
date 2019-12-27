//
//  BannerCollectionViewDelegate.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class BannerCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  private var size: CGSize
  private weak var delegate: HomePageViewControllerDelegate?
  
  init(size: CGSize, delegate: HomePageViewControllerDelegate) {
    self.size = size
    self.delegate = delegate
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return size
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    delegate?.setCurrentPage()
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    delegate?.removeTimer()
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    delegate?.addTimer()
  }
}
