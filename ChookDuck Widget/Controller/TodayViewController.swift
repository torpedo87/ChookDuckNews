//
//  TodayViewController.swift
//  ChookDuck Widget
//
//  Created by junwoo on 2017. 10. 13..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit
import NotificationCenter
import Fuzi

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    extensionContext?.widgetLargestAvailableDisplayMode = .expanded
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    DataService.instance.fetchFeed { (newsDict) in
      self.tableView.reloadData()
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
  }
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    completionHandler(NCUpdateResult.newData)
  }
  
  func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
    let expanded = activeDisplayMode == .expanded
    preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 200) : maxSize
  }
  
  @IBAction func reloadBtnPressed(_ sender: Any) {
    DataService.instance.fetchFeed { (newsDict) in
      self.tableView.reloadData()
    }
  }
}

extension TodayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let url = URL(string: DataService.instance.articles[indexPath.row].articleUrl) else { return }
    extensionContext?.open(url, completionHandler: nil)
  }
}

extension TodayViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataService.instance.articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCell {
      cell.configureCell(index: indexPath.row)
      
      return cell
    }
    
    return CustomCell()
  }
  
}
