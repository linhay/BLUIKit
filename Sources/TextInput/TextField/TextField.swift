
//  TextField.swift
//  BLUIKit
//
//  Created by linhey on 2016/11/26.


import UIKit

@IBDesignable
open class TextField: UITextField,TextInputProtocol {
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
  /// 占位文本控件
  public lazy var placeholderLabel: UILabel? = {
    return self.value(forKey: "_placeholderLabel") as? UILabel
  }()
  
  /// 历史文本
  private var lastText = ""
  
  private var inputHelp: TextFieldHelp?
  
  override open var delegate: UITextFieldDelegate? {
    get { return inputHelp }
    set { inputHelp = TextFieldHelp(delegate: newValue)
      super.delegate = inputHelp
    }
  }
  
  open override var isEditing: Bool {
    if placeholderEdgeInsets != .zero {
      drawPlaceholder(in: self.bounds)
    }
    return super.isEditing
  }
  
  override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if canPerformAction(self, action: action) {
      return super.canPerformAction(action, withSender: sender)
    }
    return false
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    buildConfig()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    buildConfig()
  }
  
  open override func drawPlaceholder(in rect: CGRect) {
    super.drawPlaceholder(in: rect)
    guard placeholderEdgeInsets != .zero, var labelFarme = placeholderLabel?.frame else{ return }
    
    if !(placeholderEdgeInsets.top == 0 && placeholderEdgeInsets.bottom == 0) {
      if placeholderEdgeInsets.top != 0 && placeholderEdgeInsets.bottom != 0 {
        labelFarme.origin.y = placeholderEdgeInsets.top
        labelFarme.size.height = rect.height - placeholderEdgeInsets.top - placeholderEdgeInsets.bottom
      } else if placeholderEdgeInsets.top != 0 {
        labelFarme.origin.y = placeholderEdgeInsets.top
      } else if placeholderEdgeInsets.bottom == 0 {
        labelFarme.origin.y = rect.height - labelFarme.height - placeholderEdgeInsets.bottom
      }
    }
    
    if !(placeholderEdgeInsets.left == 0 && placeholderEdgeInsets.right == 0) {
      if placeholderEdgeInsets.left != 0 && placeholderEdgeInsets.right != 0 {
        labelFarme.origin.x = placeholderEdgeInsets.right
        labelFarme.size.width = rect.width - placeholderEdgeInsets.left - placeholderEdgeInsets.right
      } else if placeholderEdgeInsets.left != 0 {
        labelFarme.origin.x = placeholderEdgeInsets.left
      } else if placeholderEdgeInsets.right == 0 {
        labelFarme.origin.x = rect.width - placeholderEdgeInsets.left - placeholderEdgeInsets.right
      }
    }
    
    placeholderLabel?.frame = labelFarme
  }
  
  /// MARK: - Deinitialized
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}

/// MARK: - Config
extension TextField{
  
  func buildConfig() {
    delegate = nil
    matchs = TextInputConfig.matchs
    filters = TextInputConfig.filters
    disables = TextInputConfig.disables
    buildNotifications()
  }
  
  fileprivate func buildNotifications() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(textField(changed:)),
                                           name: Notification.Name.UITextFieldTextDidChange,
                                           object: nil)
  }
  
}

extension TextField {
  @objc private func textField(changed not: Notification) {
    guard let input = not.object as? TextField, self == input else { return }
    textDidChange(input: input, text: input.text ?? "", lastText: lastText) { (res) in
      input.text = res
      lastText = res
    }
  }
}





