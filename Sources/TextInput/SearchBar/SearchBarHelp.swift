//
//  SearchBarHelp.swift
//  BLUIKit
//
//  Created by linhey on 2018/6/13.
//

import UIKit

public class SearchBarHelp: TextInputDelegate, UISearchBarDelegate {
  
  @available(iOS 2.0, *)
  public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    return textInputDelegate?.searchBarShouldBeginEditing?(searchBar) ?? true
  }
  
  @available(iOS 2.0, *)
  public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    textInputDelegate?.searchBarTextDidBeginEditing?(searchBar)
  }
  
  @available(iOS 2.0, *)
  public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool{
    return textInputDelegate?.searchBarShouldEndEditing?(searchBar) ?? true
  }
  
  @available(iOS 2.0, *)
  public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    textInputDelegate?.searchBarTextDidEndEditing?(searchBar)
  }
  
  @available(iOS 2.0, *)
  public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    textInputDelegate?.searchBar(searchBar, textDidChange: searchText)
    guard let searchBar = searchBar as? SearchBar, let input = searchBar.searchField else { return }
    searchBar.textDidChange(input: input, text: input.text ?? "", lastText: searchBar.lastText) { (res) in
      if res != searchBar.text { searchBar.text = res }
      searchBar.lastText = res
    }
  }
  
  @available(iOS 3.0, *)
  public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if let flag = textInputDelegate?.searchBar?(searchBar, shouldChangeTextIn: range, replacementText: text),!flag { return flag }
    guard  let searchBar = searchBar as? SearchBar, let input = searchBar.searchField else { return true }
    return searchBar.shouldChange(input: input, range: range, string: text)
  }
  
  @available(iOS 2.0, *)
  public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    textInputDelegate?.searchBarSearchButtonClicked?(searchBar)
  }
  
  @available(iOS 2.0, *)
  public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
    textInputDelegate?.searchBarBookmarkButtonClicked?(searchBar)
  }
  
  @available(iOS 2.0, *)
  public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    textInputDelegate?.searchBarCancelButtonClicked?(searchBar)
  }
  
  @available(iOS 3.2, *)
  public func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
    textInputDelegate?.searchBarResultsListButtonClicked?(searchBar)
  }
  
  @available(iOS 3.0, *)
  public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
    textInputDelegate?.searchBar?(searchBar, selectedScopeButtonIndexDidChange: selectedScope)
  }
  
}
