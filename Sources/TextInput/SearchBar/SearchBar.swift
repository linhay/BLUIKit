//
//  SearchBar.swift
//  BLUIKit
//
//  Created by linhey on 2018/6/12.
//

import UIKit

public class SearchBar: UISearchBar,TextInputProtocol {
  /// 文字过滤与转换
  public var filters: [TextInputFilter] = []
  /// 判断输入是否合法的
  public var matchs: [TextInputMatch] = []
  /// 字数限制
  public var wordLimit: Int = Int.max
  /// 菜单禁用项
  public var disables: [TextInputDisableState] = []
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
  
}

/// MARK: - Config
extension SearchBar{
  
  func buildConfig() {
    delegate = nil
    matchs = TextInputConfig.matchs
    filters = TextInputConfig.filters
    disables = TextInputConfig.disables
  }
  
}


