//
//  CastCollectionViewDatasourse.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/14.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import UIKit

class CastCollectionViewDatasourse: NSObject, UICollectionViewDataSource {
  private var staffs = [Person]()
  
  init(staffs: [Person]) {
    self.staffs = staffs
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return staffs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as? CastCell else {
      fatalError("Can not create cell")
    }
    cell.configure(withStaff: staffs[indexPath.item])
    return cell
  }
}
