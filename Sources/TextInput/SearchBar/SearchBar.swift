//
//  SearchBar.swift
//  BLUIKit
//
//  Created by linhey on 2018/6/12.
//

import UIKit

public class SearchBar: UISearchBar,TextInputProtocol {
  /// 字数限制
  public var wordLimit: Int = TextInputConfig.wordLimit
  /// 文字超出字符限制执行
  public var overWordLimitEvent: ((String) -> ())? = TextInputConfig.overWordLimitEvent
  /// 文字过滤与转换
  public var filters: [TextInputFilter] = TextInputConfig.filters
  /// 判断输入是否合法的
  public var matchs: [TextInputMatch] = TextInputConfig.matchs
  /// 菜单禁用项
  public var disables: [TextInputDisableState] = TextInputConfig.disables
  
  /// 设置占位文本偏移
  public var placeholderEdgeInsets: UIEdgeInsets = .zero
  
  /// 历史文本
  var lastText = ""
  
  /// 输入控件
  public lazy var searchField: UITextField? = {
    return self.value(forKey: "_searchField") as? UITextField
  }()
  
  private var inputHelp: SearchBarHelp?
  
  public override var delegate: UISearchBarDelegate? {
    get { return inputHelp }
    set { inputHelp = SearchBarHelp(delegate: newValue)
      super.delegate = inputHelp
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    buildConfig()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    buildConfig()
  }
  
  public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if canPerformAction(self, text: text ?? "", action: action) {
      return super.canPerformAction(action, withSender: sender)
    }
    return false
  }
  
}

/// MARK: - Config
extension SearchBar{
  
  func buildConfig() {
    delegate = nil
  }
  
}


