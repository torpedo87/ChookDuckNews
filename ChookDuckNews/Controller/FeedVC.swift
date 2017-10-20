//
//  FeedVC.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 12..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit
import Fuzi

class FeedVC: UIViewController {
  
  var tableView = UITableView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    
    self.view.addSubview(tableView)
    let addTeamBtnItem = UIBarButtonItem(title: "Select Team", style: .plain, target: self, action: #selector(FeedVC.addBtnPressed))
    self.navigationItem.setRightBarButton(addTeamBtnItem, animated: true)
    NotificationCenter.default.addObserver(self, selector: #selector(FeedVC.redraw(_:)), name: NOTI_CLUB_CHANGED, object: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if ClubDataService.instance.selectedClub != nil {
      DataService.instance.fetchFeed { (success) in
        if success {
          self.tableView.reloadData()
        }
      }
    }
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.snp.makeConstraints { (make) in
      make.bottom.left.right.equalTo(self.view)
      make.top.equalTo(self.view).offset(20)
    }
  }
  
  @objc func addBtnPressed() {
    let selectTeamVC = SelectTeamVC()
    self.navigationController?.pushViewController(selectTeamVC, animated: true)
  }
  
  @objc func redraw(_ notification: Notification) {
    tableView.reloadData()
  }

}

extension FeedVC: UITableViewDelegate {
  
}

extension FeedVC: UITableViewDataSource {
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
    } else {
      return CustomCell()
    }
  }
  
}
