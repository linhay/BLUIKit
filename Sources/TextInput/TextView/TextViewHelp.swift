//
//  TextViewHelp.swift
//  BLUIKit
//
//  Created by linhey on 2018/6/13.
//

import UIKit

class TextViewHelp: TextInputDelegate, UITextViewDelegate {
  
  @available(iOS 2.0, *)
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
    if let input = textView as? TextView {
      input.placeholderLabel.isHidden = true
    }
    return textInputDelegate?.textViewShouldBeginEditing?(textView) ?? true
  }
  
  @available(iOS 2.0, *)
  public func textViewShouldEndEditing(_ textView: UITextView) -> Bool{
    if let input = textView as? TextView {
      input.placeholderLabel.isHidden = !input.lastText.isEmpty
    }
    return textInputDelegate?.textViewShouldEndEditing?(textView) ?? true
  }
  
  @available(iOS 2.0, *)
  public func textViewDidBeginEditing(_ textView: UITextView){
    textInputDelegate?.textViewDidBeginEditing?(textView)
  }
  
  @available(iOS 2.0, *)
  public func textViewDidEndEditing(_ textView: UITextView){
    textInputDelegate?.textViewDidEndEditing?(textView)
  }
  
  @available(iOS 2.0, *)
  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
    if let flag = textInputDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text),!flag { return flag }
    guard let input = textView as? TextView else { return true }
    return input.shouldChange(input: input, range: range, string: text)
  }
  
  
  @available(iOS 2.0, *)
  public func textViewDidChange(_ textView: UITextView){
    textInputDelegate?.textViewDidChange?(textView)
  }
  
  @available(iOS 2.0, *)
  public func textViewDidChangeSelection(_ textView: UITextView){
    textInputDelegate?.textViewDidChangeSelection?(textView)
  }
  
  @available(iOS 10.0, *)
  public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool{
    return textInputDelegate?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? true
  }
  
  @available(iOS 10.0, *)
  public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool{
    return textInputDelegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? true
    
  }
  
  
  @available(iOS, introduced: 7.0, deprecated: 10.0, message: "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead")
  public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool{
    return textInputDelegate?.textView?(textView, shouldInteractWith: URL, in: characterRange) ?? true
  }
  
  @available(iOS, introduced: 7.0, deprecated: 10.0, message: "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead")
  public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool{
    return textInputDelegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange) ?? true
  }
}
