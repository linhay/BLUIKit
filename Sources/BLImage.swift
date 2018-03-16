//
//  BLImage.swift
//  BLUIKit
//
//  Created by linhey on 2018/3/13.
//

import UIKit

class BLImage {
  /*
   png: http://www.libpng.org/pub/png/spec/1.2/PNG-Structure.html
   */
  enum Format {
    case unknown
    case png
    case jpeg
    case gif
  }
  
  class func format(data: Data) -> Format {
    var buffer = [UInt8](repeating: 0, count: 8)
    (data as NSData).getBytes(&buffer, length: 8)
    let gifHeader: [UInt8] = [0x47,0x49,0x46,0x38]
    if gifHeader[0..<gifHeader.count] == buffer[0..<gifHeader.count] { return .gif }
    let pngHeader: [UInt8] = [0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A]
    if pngHeader[0..<pngHeader.count] == buffer[0..<pngHeader.count] { return .png }
    let jpgHeader: [UInt8] = [0xFF,0xD8,0xFF]
    if jpgHeader[0..<jpgHeader.count] == buffer[0..<jpgHeader.count] { return .jpeg }
    return .unknown
  }
}

/*
     let source = CGImageSourceCreateWithData(self as CFData, nil)
     let cgimage = CGImageSourceCreateImageAtIndex(source!, 0, nil)
     //数据提供者
     cgimage?.dataProvider
     //返回位图图像是否为图像蒙版。
     cgimage?.isMask
     //返回位图图像的宽度。
     cgimage?.width
     //返回位图图像的高度。
     cgimage?.height
     //返回为位图图像的单个颜色分量分配的位数。
     cgimage?.bitsPerComponent
     //返回为位图图像中的单个像素分配的位数。
     cgimage?.bitsPerPixel
     //返回分配给位图图像单行的字节数。
     cgimage?.bytesPerRow
     //返回位图图像的颜色空间。
     cgimage?.colorSpace
     //返回位图图像的Alpha通道信息。
     cgimage?.alphaInfo
     //返回位图图像的解码数组。
     cgimage?.decode
     //返回位图图像的插值设置。
     cgimage?.shouldInterpolate
     //返回位图图像的呈现意图设置。
     cgimage?.renderingIntent
     //返回位图图像的位图信息。
     cgimage?.bitmapInfo
     //图像的通用类型标识符。
     //cgimage?.utType
 */

