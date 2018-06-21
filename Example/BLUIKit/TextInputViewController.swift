//
//  ViewController.swift
//  BLUIKit
//
//  Created by linhey on 10/28/2017.
//  Copyright (c) 2017 linhey. All rights reserved.
//

import UIKit
import BLUIKit
import SHCHUD

class TextInputViewController: UIViewController {
  
  lazy var textField: TextField = {
    let item = TextField()
    item.placeholder = "placeholder"
    item.placeholderEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 0, right: 0)
    item.frame = CGRect(x: 15, y: 100, width: view.bounds.width - 30, height: 60)
    self.view.addSubview(item)
    item.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    return item
  }()
  
  lazy var searchBar: SearchBar = {
    let item = SearchBar()
    item.frame = CGRect(x: 15, y: 350, width: view.bounds.width - 30, height: 60)
    self.view.addSubview(item)
    item.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    return item
  }()
  
  lazy var textView: TextView = {
    let item = TextView()
    item.placeholder = "placeholder"
    item.frame = CGRect(x: 15, y: 180, width: view.bounds.width - 30, height: 150)
    self.view.addSubview(item)
    item.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    return item
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    TextInputConfig.filters = [TextInputFilter(rule: { (item) -> String in
      return item.replacingOccurrences(of: "[\\笑脸]", with: "😁")
    })]
    
    TextInputConfig.overWordLimitEvent = { (text) in
      HUD.show(string: text)
    }
    
    view.backgroundColor = .white
    textField.wordLimit = 30
    textView.wordLimit = 50
    searchBar.backgroundColor = UIColor.white
  }
  
}
