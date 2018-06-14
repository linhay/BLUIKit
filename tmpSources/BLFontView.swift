//
//  IconView.swift
//  KeyChain
//
//  Created by bigl on 2017/12/26.
//  Copyright © 2017年 keychain.linhey.com. All rights reserved.
//

import UIKit

@IBDesignable
open class BLFontView: UIView {

  /// 字体名称
  @IBInspectable open var fontName: String = "" {
    didSet{
      adjustIconFont()
    }
  }

  /// 字体大小, 默认0则自适应view高度
  @IBInspectable open var fontSize: CGFloat = 0 {
    didSet{
      adjustIconFont()
    }
  }

  /// 字体颜色, 默认为黑色
  @IBInspectable open var fontColor: UIColor = UIColor.black {
    didSet{
      adjustIconFont()
    }
  }

  /// 字符Unicode 16进制字符标量
  @IBInspectable open var fontUnicode: String = "" {
    didSet{
      adjustIconFont()
    }
  }


  /// 字体绘制倍率, 默认5倍,最大20倍 用于提高字体清晰度
  @IBInspectable open var fontScale: Double = 5 {
    didSet{
      adjustIconFont()
    }
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    adjustIconFont()
  }

  private func adjustIconFont() {
    guard bounds.size.width != 0, bounds.size.height != 0 else{ return }
    guard fontScale > 0 else { return }
    guard fontSize >= 0 else { return }
    guard !fontName.isEmpty else { return }
    var scale = CGFloat(fontScale)
    if scale > 20 { scale = 20 }
    let iconHeight = fontSize == 0 ? bounds.height * scale : fontSize
    guard let font = UIFont(name: fontName, size: iconHeight) else { return }
    let contextSize = CGSize(width: bounds.size.width * scale,
                             height: bounds.size.height * scale)

    let point = CGPoint(x: (contextSize.width - iconHeight) * 0.5,
                        y: (contextSize.height - iconHeight) * 0.5)

    guard let unicode = getInt(from: fontUnicode) else { return }
    guard let iconName = UnicodeScalar(unicode)?.description else { return }

      UIGraphicsBeginImageContext(contextSize)
      guard let context = UIGraphicsGetCurrentContext() else {
        UIGraphicsEndImageContext()
        return
      }
      (iconName as NSString).draw(at: point,
                                  withAttributes: [.foregroundColor : fontColor,
                                                   .font: font])
      if let cgImage = context.makeImage() {
        layer.contents = cgImage
      }
      UIGraphicsEndImageContext()
  }

  /// 从16进制字符串/或者单字符 获取Int类型
  ///
  /// - Parameter hexString: 16进制字符串
  /// - Returns: Int值
  private func getInt(from hexString: String) -> Int? {
    func hexValue(from string: String) -> Int {
      var sum = 0
      for i in string.utf8 {
        sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
        if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
          sum -= 7
        }
      }
      return sum
    }

    if hexString.count == 1 {
      guard let int32 = hexString.unicodeScalars.first?.value else { return nil }
      return Int(int32)
      }
    var str = hexString.uppercased()
    guard str.hasPrefix("0X") else { return hexValue(from: str) }
    str = str.replacingOccurrences(of: "0X", with: "")
    return hexValue(from: str)
  }

}
