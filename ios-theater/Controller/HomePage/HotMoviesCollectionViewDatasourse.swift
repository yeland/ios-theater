//
//  HotMoviesCollectionViewDatasourse.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class HotMoviesCollectionViewDatasourse: NSObject, UICollectionViewDataSource {
  private let hotMoviesNumber = 6
  private var hotMovies = [Movie]()
  
  func setHotMovies(withHotMovies hotMovies: [Movie]) {
    self.hotMovies = hotMovies
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return hotMoviesNumber > hotMovies.count ? hotMovies.count : hotMoviesNumber
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as? MovieCollectionCell else {
      fatalError("Can not create cell")
    }
    cell.configure(movie: hotMovies[indexPath.item])
    return cell
  }
}
