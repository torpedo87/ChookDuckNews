//
//  SelectTeamVC.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 20..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit

class SelectTeamVC: UIViewController {

  var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //view.backgroundColor = UIColor.white
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(TeamCell.self, forCellReuseIdentifier: "teamCell")
    
    view.addSubview(tableView)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.snp.makeConstraints { (make) in
      make.left.bottom.right.equalTo(self.view)
      make.top.equalTo(self.view).offset(20)
    }
  }
}

extension SelectTeamVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let club = ClubDataService.instance.countries[indexPath.section].league[indexPath.row]
    ClubDataService.instance.selectedClub = club
    NotificationCenter.default.post(name: NOTI_CLUB_CHANGED, object: nil)
    dismiss(animated: true, completion: nil)
  }
}

extension SelectTeamVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return ClubDataService.instance.countries.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ClubDataService.instance.countries[section].name
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ClubDataService.instance.countries[section].league.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as? TeamCell {
      cell.configureCell(indexPath: indexPath)
      return cell
    } else {
      return UITableViewCell()
    }
  }
}
