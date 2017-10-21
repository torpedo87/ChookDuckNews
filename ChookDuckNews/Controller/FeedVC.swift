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
  var addButtom = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    
    self.view.addSubview(tableView)
    self.view.addSubview(addButtom)
    addButtom.setImage(UIImage(named: "team"), for: UIControlState.normal)
    addButtom.addTarget(self, action: #selector(FeedVC.addBtnPressed), for: .touchUpInside)
    NotificationCenter.default.addObserver(self, selector: #selector(FeedVC.redraw(_:)), name: NOTI_CLUB_CHANGED, object: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard let myClub = DataService.instance.selectedClub else { return }
    
    DataService.instance.fetchFeed() { (success) in
      if success {
        self.tableView.reloadData()
      }
    }
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.snp.makeConstraints { (make) in
      make.bottom.left.right.equalTo(self.view)
      make.top.equalTo(self.view).offset(20)
    }
    
    addButtom.snp.makeConstraints { (make) in
      make.width.height.equalTo(100)
      make.right.bottom.equalTo(self.view).offset(-10)
    }
  }
  
  @objc func addBtnPressed() {
    let selectTeamVC = SelectTeamVC()
    present(selectTeamVC, animated: true, completion: nil)
  }
  
  @objc func redraw(_ notification: Notification) {
    guard let myClub = DataService.instance.selectedClub else { return }
    
    DataService.instance.fetchFeed() { (success) in
      if success {
        self.tableView.reloadData()
      }
    }
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
