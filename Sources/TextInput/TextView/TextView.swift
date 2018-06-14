//
//  TextView.swift
//  BLUIKit
//
//  Created by linhey on 2016/11/26.
//

import UIKit

public class TextView: UITextView,TextInputProtocol {
  
  /// 文字过滤与转换
  public var filters: [TextInputFilter] = []
  /// 判断输入是否合法的
  public var matchs: [TextInputMatch] = []
  /// 菜单禁用项
  public var disables: [TextInputDisableState] = []
  /// 字数限制
  public var wordLimit = Int.max
  
  private var inputHelp: TextViewHelp?
  
  lazy var placeholderLabel: UILabel = {
    let item = UILabel()
    item.font = font
    item.numberOfLines = 0
    item.textColor = UIColor(red: 0, green: 0, blue: 0.1, alpha: 0.22)
    item.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(item)
    let views = ["label": item]
   let hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|",
                                                    options: NSLayoutFormatOptions(rawValue: 0),
                                                    metrics: nil,
                                                    views: views)
    
    let vConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-3-[label]-5-|",
                                                     options: NSLayoutFormatOptions(rawValue: 0),
                                                     metrics: nil,
                                                     views: views)
    self.addConstraints(hConstraint + vConstraint)
    return item
  }()
  
  override open var delegate: UITextViewDelegate? {
    get { return inputHelp }
    set { inputHelp = TextViewHelp(delegate: newValue)
      super.delegate = inputHelp
    }
  }
  
  /// 文本框文本
  public override var text: String!{
    set {
      if newValue == text { return }
      super.text = newValue
      lastText = newValue
    }
    get {
      return super.text
    }
  }
  
  /// 历史文本
  public var lastText = ""{
    didSet{
      if lastText == oldValue { return }
      placeholderLabel.isHidden = !lastText.isEmpty
      guard wordLimit != Int.max else { return }
    }
  }
  
  /// 占位文字
  public var placeholder: String?{
    set{ placeholderLabel.text = newValue }
    get{ return placeholderLabel.text }
  }
  
  public override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    buildConfig()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    buildConfig()
  }
  
  override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if canPerformAction(self, text: text, action: action) {
      return super.canPerformAction(action, withSender: sender)
    }
    return false
  }
  
  public func textInput(overWordLimit text: String) {
    
  }
  
  //MARK: - Deinitialized
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}

// MARK: - Config
extension TextView{
  
  func buildConfig() {
    delegate = nil
    matchs = TextInputConfig.matchs
    filters = TextInputConfig.filters
    disables = TextInputConfig.disables
    buildNotifications()
  }
  
  fileprivate func buildNotifications() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(textView(changed:)),
                                           name: Notification.Name.UITextViewTextDidChange,
                                           object: nil)
  }
}

extension TextView {
  @objc private func textView(changed not: Notification) {
    guard let input = not.object as? TextView, self == input else { return }
    textDidChange(input: input, text: input.text, lastText: lastText) { (res) in
      if res != input.text { input.text = res }
      lastText = res
    }
  }
  
}

