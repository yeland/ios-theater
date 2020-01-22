//
//  CommentTableViewDataSourse.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/22.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import Foundation

class CommentTableViewDatasourse: NSObject, UITableViewDataSource {
  private var comments = [Comment]()
  
  init(comments: [Comment]) {
    self.comments = comments
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else {
      fatalError("Can not create cell")
    }
    cell.configure(withComment: comments[indexPath.row])
    
    return cell
  }
}
