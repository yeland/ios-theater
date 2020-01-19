//
//  IntroduceLabel.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/13.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import UIKit

class IntroduceLabel: UILabel {
  private var summary = ""
  
  func configure(withSummary summary: String) {
    self.summary = summary
    let linesArray = summary.getLinesArrayFromLabel(font: self.font, rect: self.frame)
    var introductionString: NSMutableAttributedString
    if linesArray.count <= 4 {
      introductionString = NSMutableAttributedString(string: summary)
    } else {
      introductionString = NSMutableAttributedString(string: linesArray[0] + linesArray[1] + linesArray[2])
      let fourthLine = generateFourthLine(content: linesArray[3])
      introductionString.append(fourthLine)
    }
    self.attributedText = introductionString
    setupLineSpacing()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(clickToShowMore))
    self.isUserInteractionEnabled = true
    self.addGestureRecognizer(tap)
  }
  
  private func generateFourthLine(content: String) -> NSAttributedString {
    let readMore = NSLocalizedString("readMore", comment: "")
    let rect = self.frame
    let width = rect.width - readMore.getWidth(font: self.font)
    let frame = CGRect(x: 0, y: 0, width: width, height: rect.height)
    let fourthLines = content.getLinesArrayFromLabel(font: self.font, rect: frame)
    let fourthLine = NSMutableAttributedString(string: fourthLines[0])
    if fourthLines.count == 1 {
      fourthLine.replaceCharacters(in: NSRange(location: fourthLine.length - 1, length: 1), with: readMore)
    } else {
      fourthLine.append(NSAttributedString(string: readMore))
    }
    fourthLine.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: fourthLine.length - readMore.count, length: readMore.count))
    return fourthLine
  }
  
  @objc private func clickToShowMore() {
    let introductionString = NSMutableAttributedString(string: summary)
    self.attributedText = introductionString
    setupLineSpacing()
  }
  
  private func setupLineSpacing() {
    let attributedString = self.attributedText ?? NSAttributedString(string: "")
    let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 6
    mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttributedString.length))
    self.attributedText = mutableAttributedString
  }
}
