//
//  UILabel+LinesArray.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/10.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import Foundation

extension UILabel {
  func getLinesArrayFromLabel(content: String) -> [String] {
    let text:NSString = content as NSString
    let font:UIFont = self.font
    let rect:CGRect = self.frame
    
    let myFont:CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
    let attStr:NSMutableAttributedString = NSMutableAttributedString(string: text as String)
    attStr.addAttribute(NSAttributedString.Key(rawValue: String(kCTFontAttributeName)), value:myFont, range: NSMakeRange(0, attStr.length))
    let frameSetter:CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
    let path:CGMutablePath = CGMutablePath()
    path.addRect(CGRect(x:0, y:0, width:rect.size.width, height:100000))
    
    let frame:CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
    let lines = CTFrameGetLines(frame) as NSArray
    var linesArray = [String]()
    
    for line in lines {
      let lineRange = CTLineGetStringRange(line as! CTLine)
      let range:NSRange = NSMakeRange(lineRange.location, lineRange.length)
      let lineString = text.substring(with: range)
      linesArray.append(lineString as String)
    }
    return linesArray
  }
}
