//
//  MainViewController.swift
//  BLUIKit_Example
//
//  Created by linhey on 2018/6/21.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  enum CellType: String {
    case textInput = "textInput"
  }
  
  let cells = [CellType.textInput]
  
  var tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.frame = view.bounds
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cells.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch cells[indexPath.item] {
    case .textInput:
      let vc = TextInputViewController()
      navigationController?.pushViewController(vc, animated: true)
    default:
      return
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    cell?.textLabel?.text = cells[indexPath.item].rawValue
    return cell!
  }
  
}
