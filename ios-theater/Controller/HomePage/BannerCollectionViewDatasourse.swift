//
//  BannerCollectionViewDatasourse.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class BannerCollectionViewDatasourse: NSObject, UICollectionViewDataSource {
  private var imageNames = [String]()
  private var largeNumberForSections: Int
  
  init(imageNames: [String], number: Int) {
    self.imageNames = imageNames
    largeNumberForSections = number
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return largeNumberForSections
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
      fatalError("Can not create cell")
    }
    cell.configure(imageName: imageNames[indexPath.item])
    return cell
  }
}
