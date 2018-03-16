//
//  BLImageView.swift
//  BLUIKit
//
//  Created by linhey on 2018/3/13.
//

import UIKit
import MobileCoreServices

open class BLImageView: UIImageView {
  
  public init() {
    super.init(image: nil)
  }
  
  public init(data: Data) {
    super.init(image: nil)
    play(data: data)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}

public extension BLImageView {
  
  struct GIF {
    let images: [UIImage]
    let duration: TimeInterval
  }
  
  func gifCoder(data: Data,call: @escaping ((_:GIF?)->())){
    DispatchQueue.global().async {
      // kCGImageSourceShouldCache : 表示是否在存储的时候就解码
      // kCGImageSourceTypeIdentifierHint : 指明source type
      let options: NSDictionary = [kCGImageSourceShouldCache: NSNumber(value: true),
                                   kCGImageSourceTypeIdentifierHint: kUTTypeGIF]
      guard let source = CGImageSourceCreateWithData(data as CFData, options) else { return }
      // 获取gif帧数
      let frameCount = CGImageSourceGetCount(source)
      var duration : TimeInterval = 0
      let images = (0..<frameCount).flatMap { (index) -> UIImage? in
        // 获取对应帧的 CGImage
        guard let cgImage = CGImageSourceCreateImageAtIndex(source, index, options) else { return nil }
        // gif 动画
        // 获取到 gif每帧时间间隔
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, index, nil),
          let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
          let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else{ return nil }
        duration += frameDuration.doubleValue
        // 获取帧的img
        let  image = UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        return image
      }
      DispatchQueue.main.async {
        call(GIF(images: images, duration: duration))
      }
    }
  }
  
  public func play(data: Data) {
    switch BLImage.format(data: data) {
    case .gif:
      gifCoder(data: data) { (gif) in
        self.animationImages = gif?.images
        self.animationDuration = gif?.duration ?? 0
        self.animationRepeatCount = 0
        self.startAnimating()
      }
    default:
      image = UIImage(data: data)
    }
  }
  
}
