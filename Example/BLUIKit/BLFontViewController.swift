//
//  BLFontViewController.swift
//  BLUIKit_Example
//
//  Created by bigl on 2017/12/26.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import BLUIKit

class BLFontViewController: UIViewController {

  @IBOutlet weak var fontView: BLFontView!
  @IBOutlet weak var heightValueLabel: UILabel!
  @IBOutlet weak var scaleValueLabel: UILabel!
  @IBOutlet weak var fontHeightValueLabel: UILabel!
  @IBOutlet weak var viewHeghtConstaint: NSLayoutConstraint!

  @IBAction func heightValueChanged(_ sender: UISlider) {
    let value = CGFloat(sender.value.rounded())
    if viewHeghtConstaint.constant == value { return }
    heightValueLabel.text = String(format: "%.2f", value)
    viewHeghtConstaint.constant = value
  }

  @IBAction func scaleValueChanged(_ sender: UISlider) {
    let value = Double(sender.value).rounded()
    if fontView.fontScale == value { return }
    scaleValueLabel.text = String(format: "%.2f", value)
    fontView.fontScale = value
  }

  @IBAction func fontHeightChanged(_ sender: UISlider) {
    let value = CGFloat(sender.value * 10).rounded() / 10
    if fontView.fontSize == value { return }
    fontHeightValueLabel.text = String(format: "%.2f", value)
    fontView.fontSize = value
  }
  

}
