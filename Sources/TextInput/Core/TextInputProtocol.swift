//
//  TextInputProtocol.swift
//  BLUIKit
//
//  Created by linhey on 2018/6/8.
//

import UIKit

/// 禁用状态
///
/// - none: 默认, 不禁用
/// - all: 全部禁用
/// - cut: 剪切
/// - copy: 复制
/// - paste: 粘贴
/// - select: 选择
/// - selectAll: 全选
/// - delete: 删除
public enum TextInputDisableState {
  case none
  case all
  case cut
  case copy
  case paste
  case select
  case selectAll
  case delete
}

public struct TextInputFilter {
  var code: (_ text: String) -> String
  public init(rule: @escaping (_ text: String) -> String) {
    self.code = rule
  }
}

public struct TextInputMatch {
  var code: (_ text: String) -> Bool
  public init(rule: @escaping (_ text: String) -> Bool) {
    self.code = rule
  }
  
  public init(regex: String) {
    self.init { (text) -> Bool in
      do {
        let reg = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
        return !reg.matches(in: text, options: [], range: NSMakeRange(0, text.utf16.count)).isEmpty
      }catch{
        return true
      }
    }
  }
}


public protocol TextInputProtocol: NSObjectProtocol {
  /// 文字过滤与转换
  var filters: [TextInputFilter] { set get }
  /// 判断输入是否合法的
  var matchs: [TextInputMatch] { set get }
  /// 字数限制
  var wordLimit: Int { set get }
  /// 菜单禁用项
  var disables: [TextInputDisableState] { set get }
  /// 超过字数限制
  var overWordLimitEvent: ((_ text: String)->())? { set get }
}

public extension TextInputProtocol {
  
  /// 获取输入后文本
  ///
  /// - Parameters:
  ///   - string: 原有字符串
  ///   - text: 插入字符
  ///   - range: 插入字符范围
  /// - Returns: 处理后文本
  public func getAfterInputText(string: String,text: String,range: NSRange) -> String {
    var result = string
    // 删除操作
    switch text.isEmpty {
    case true:
      let startIndex = String.Index(encodedOffset: range.location)
      let endIndex = String.Index(encodedOffset: range.location + range.length)
      // 全选删除
      if startIndex <= result.startIndex {
        result = String(result[endIndex..<result.endIndex])
      }
        // 尾部删除
      else if endIndex >= result.endIndex {
        result = String(result[result.startIndex...startIndex])
      }
        // 局部删除
      else{
        result = String(result[result.startIndex...startIndex]) + String(result[endIndex..<result.endIndex])
      }
    case false:
      /// 正常输入
      let startIndex = String.Index(encodedOffset: range.location)
      let endIndex = String.Index(encodedOffset: range.location + range.length)
      // 头部添加
      if startIndex <= result.startIndex, range.length == 0 {
        result = text + result
      }
        // 尾部添加
      else if endIndex >= result.endIndex, range.length == 0 {
        result = result + text
      }
        // 局部替换
      else{
        result = String(result[result.startIndex..<startIndex]) + text + String(result[endIndex..<result.endIndex])
      }
    }
    return result
  }
  
  func textDidChange(input: UITextInput,
                     text: String,
                     lastText: String,
                     call: (_ result: String) -> ()) {
    guard input.markedTextRange == nil,let range = input.selectedTextRange else { return }
    
    let result1 = filter(text: text)
    let result2 = match(text: result1) ? result1 : lastText
    
    call(result2)
    
    if result2 == text {
      input.selectedTextRange = range
      return
    }
    var offset = 0
    var compare1 = result2
    var compare2 = text
    for _ in 0..<min(result2.count, text.count) {
      if compare1.removeLast() == compare2.removeLast() {
        offset -= 1
      }else{
        break
      }
    }
    
    if offset >= 0 {
      input.selectedTextRange = range
      return
    }
    let preStr = result2[...String.Index(encodedOffset: result2.count + offset)]
    /// utf16: emoji 字符为 utf8
    guard let start = input.position(from: input.beginningOfDocument, offset: preStr.utf16.count) else{ return }
    input.selectedTextRange = input.textRange(from: start, to: start)
  }
  
  public func shouldChange(input: UITextInput, range: NSRange, string: String) -> Bool {
    if string.isEmpty { return true }
    guard input.markedTextRange == nil,
      let allRange = input.textRange(from: input.beginningOfDocument,
                                     to: input.endOfDocument),
      let text = input.text(in: allRange) else { return true }
    let inputStr = filter(text: string)
    let endStr = getAfterInputText(string: text, text: string, range: range)
    if !match(text: endStr) { return false }
    // 处理字符限制
    if endStr.count > wordLimit { return false }
    // 处理第三方键盘候选词输入/粘贴
    if inputStr != string,range.length != 0 { return false }
    return true
  }
  
}

public extension TextInputProtocol {
  
  /// 判断输入是否合法的
  ///
  /// - Parameter text: 待判断文本
  /// - Returns: 结构
  public func match(text: String) -> Bool {
    if text.count > wordLimit {
      overWordLimitEvent?(text)
      return false
    }
    for item in matchs {
      if !item.code(text) { return false }
    }
    return true
  }
  
}

public extension TextInputProtocol {
  /// 文本过滤
  ///
  /// - Parameter text: 待过滤文本
  /// - Returns: 过滤后文本
  public func filter(text: String) -> String {
    var text = text
    for item in filters {
      text = item.code(text)
    }
    text = filter(limit: text)
    return text
  }
  
  /// 过滤超过字符限制字符
  ///
  /// - Parameter text: 待过滤文本
  /// - Returns: 过滤后文本
  public func filter(limit text: String) -> String {
    if wordLimit == Int.max { return text }
    let endIndex = String.Index(encodedOffset: wordLimit)
    if text.count > wordLimit{
      overWordLimitEvent?(text)
      return String(text[text.startIndex..<endIndex])
    }
    
    return text
  }
  
}

public extension TextInputProtocol {
  /// 是否响应工具条事件
  ///
  /// - Parameters:
  ///   - respoder: textView & textfield
  ///   - action: 执行方法名
  /// - Returns: 是否响应
  public func canPerformAction(_ respoder: UIResponder,text: String, action: Selector) -> Bool {
    if disables.contains(.all) { return false }
    switch action {
    case #selector(respoder.cut(_:)): return !disables.contains(.cut)
    case #selector(respoder.copy(_:)): return !disables.contains(.copy)
    case #selector(respoder.paste(_:)):
      /// 处理剪切板粘贴超过字符限制
      if let str = UIPasteboard.general.string {
        return !disables.contains(.paste) && (str.count + text.count) <= wordLimit
      }
      return !disables.contains(.paste)
    case #selector(respoder.select(_:)): return !disables.contains(.select)
    case #selector(respoder.selectAll(_:)): return !disables.contains(.selectAll)
    case #selector(respoder.delete(_:)): return !disables.contains(.delete)
    default: return true
    }
  }
}
