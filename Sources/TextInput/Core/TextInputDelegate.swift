//
//  TextInputDelegate.swift
//  BLUIKit
//
//  Created by linhey on 2017/7/13.
//
//

import UIKit

public class TextInputDelegate: NSObject {
  private(set) weak var textInputDelegate: AnyObject?

 public init(delegate: AnyObject?) {
    self.textInputDelegate = delegate
  }
}
