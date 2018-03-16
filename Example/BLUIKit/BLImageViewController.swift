//
//  BLImageViewController.swift
//  BLUIKit_Example
//
//  Created by linhey on 2018/3/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import BLUIKit

class BLImageViewController: UITableViewController {
  
  var datas = [Bundle.main.path(forResource: "gif", ofType: "gif")!,
               Bundle.main.path(forResource: "jpg", ofType: "jpg")!,
               Bundle.main.path(forResource: "apng", ofType: "apng")!,
               Bundle.main.path(forResource: "svg", ofType: "svg")!].map { (str) -> Data in
                let url = URL(fileURLWithPath: str)
                return try! Data(contentsOf: url)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib.init(nibName: String(describing: BLImageCell.self),
                                  bundle: nil),
                       forCellReuseIdentifier: "cell")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return datas.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let data = datas[indexPath.row]
    let source = CGImageSourceCreateWithData(data as CFData, nil)
    let cgimage = CGImageSourceCreateImageAtIndex(source!, 0, nil)
    let width = CGFloat(cgimage?.width ?? 100)
    let height = CGFloat(cgimage?.height ?? 100)
    return tableView.bounds.width * height / width
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BLImageCell
    cell.icon.play(data: datas[indexPath.item])
    return cell
  }
  
  
}
