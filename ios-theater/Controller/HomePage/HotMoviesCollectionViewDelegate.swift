//
//  HotMoviesCollectionViewDelegate.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class HotMoviesCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  private let size = CGSize(width: 117, height: 240)
  private weak var delegate: HomePageViewControllerDelegate?
  
  init(delegate: HomePageViewControllerDelegate) {
    self.delegate = delegate
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return size
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.showDetails(item: indexPath.item)
  }
}
