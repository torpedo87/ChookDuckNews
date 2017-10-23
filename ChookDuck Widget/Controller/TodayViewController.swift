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
    
    if let clubName = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myClub") as? String {
      DataService.instance.selectedClub = Club(name: clubName)
    }
    
    tableView.delegate = self
    tableView.dataSource = self
    NotificationCenter.default.addObserver(self, selector: #selector(TodayViewController.redraw(_:)), name: NOTI_CLUB_CHANGED, object: nil)
    
    extensionContext?.widgetLargestAvailableDisplayMode = .expanded
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //guard let myClub = DataService.instance.selectedClub else { return }
    DataService.instance.fetchFeed() { (success) in
      if success {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
  }
  
  @objc func redraw(_ notification: Notification) {
    //guard let myClub = DataService.instance.selectedClub else { return }
    
    DataService.instance.fetchFeed() { (success) in
      if success {
        self.tableView.reloadData()
      }
    }
  }
  
  //위젯이 업데이트 될 때까지 최근 스냅샷을 제공
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
//    guard let myClub = DataService.instance.selectedClub else { return }
//
//    DataService.instance.fetchFeed() { (success) in
//      if success {
//        self.tableView.reloadData()
//        completionHandler(.newData)
//      } else {
//        completionHandler(.failed)
//      }
//    }
//
//    completionHandler(NCUpdateResult.newData)
  }
  
  //위젯 높이 조절
  func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
    let expanded = activeDisplayMode == .expanded
    preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 500) : maxSize
  }
  
  @IBAction func reloadBtnPressed(_ sender: Any) {
    //guard let myClub = DataService.instance.selectedClub else { return }
    
    DataService.instance.fetchFeed() { (success) in
      if success {
        self.tableView.reloadData()
      }
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
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
}
