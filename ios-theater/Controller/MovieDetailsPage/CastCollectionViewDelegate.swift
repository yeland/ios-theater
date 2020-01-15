//
//  CastCollectionViewDelegate.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/15.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import UIKit

class CastCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  private var size: CGSize
  
  init(size: CGSize) {
    self.size = size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return size
  }
}
