//
//  TextInputConfig.swift
//  BLUIKit
//
//  Created by linhey on 2018/6/8.
//

import UIKit

public struct TextInputConfig {
  /// 文字过滤与转换
  public static var filters: [TextInputFilter] = []
  /// 判断输入是否合法的
  public static var matchs: [TextInputMatch] = []
  /// 菜单禁用项
  public static var disables: [TextInputDisableState] = []
}

