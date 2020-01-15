//
//  UILabel+LinesArray.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/10.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import Foundation

extension String {
  func getLinesArrayFromLabel(font: UIFont, rect: CGRect) -> [String] {
    let text = self as NSString
    
    let myFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
    let attStr = NSMutableAttributedString(string: text as String)
    attStr.addAttribute(NSAttributedString.Key(rawValue: String(kCTFontAttributeName)), value: myFont, range: NSMakeRange(0, attStr.length))
    let frameSetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
    let path = CGMutablePath()
    path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 100000))
    
    let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
    let lines = CTFrameGetLines(frame) as NSArray
    var linesArray = [String]()
    
    for line in lines {
      let lineRange = CTLineGetStringRange(line as! CTLine)
      let range = NSMakeRange(lineRange.location, lineRange.length)
      let lineString = text.substring(with: range)
      linesArray.append(lineString)
    }
    return linesArray
  }
  
  func getWidth(font: UIFont) -> CGFloat {
    let string = NSMutableAttributedString(string: self)
    string.addAttribute(.font, value: font, range: NSRange(location: 0, length: string.length))
    return string.size().width
  }
}
