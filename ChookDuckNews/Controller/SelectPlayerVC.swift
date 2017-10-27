//
//  SelectPlayerVC.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 27..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit

class SelectPlayerVC: UIViewController {
  
  var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  
    self.navigationItem.title = "SELECT MY PLAYER"
    view.addSubview(tableView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.snp.makeConstraints { (make) in
      make.left.bottom.right.equalTo(self.view)
      make.top.equalTo((self.navigationController?.navigationBar.snp.bottom)!)
    }
    
  }
}

extension SelectPlayerVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let squad = DataService.instance.selectedClub?.squad as? [String] else { return }
    let player = squad[indexPath.row] as String
    DataService.instance.selectedPlayer = player
    
    UserDefaults.init(suiteName: "group.chookduck.samchon")?.setValue(player, forKey: "myPlayer")
    NotificationCenter.default.post(name: NOTI_PLAYER_CHANGED, object: nil)
    self.navigationController?.dismiss(animated: true, completion: nil)
  }
}

extension SelectPlayerVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let squad = DataService.instance.selectedClub?.squad else { fatalError() }
    return squad.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let squad = DataService.instance.selectedClub?.squad else { fatalError() }
    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UITableViewCell {
      cell.textLabel?.text = squad[indexPath.row]
      return cell
    } else {
      return UITableViewCell()
    }
  }
}
