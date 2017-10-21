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
    
    for i in 0..<ClubDataService.instance.leagues.count {
      ClubDataService.instance.fetchClub(league: ClubDataService.instance.leagues[i], completion: { (clubs) in
        ClubDataService.instance.leagues[i].clubs = clubs
      })
    }
    
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
    guard let clubs = ClubDataService.instance.leagues[indexPath.section].clubs else { return }
    let club = clubs[indexPath.row]
    DataService.instance.selectedClub = club
    NotificationCenter.default.post(name: NOTI_CLUB_CHANGED, object: nil)
    dismiss(animated: true, completion: nil)
  }
}

extension SelectTeamVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return ClubDataService.instance.leagues.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ClubDataService.instance.leagues[section].name
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let clubs = ClubDataService.instance.leagues[section].clubs else { fatalError() }
    return clubs.count
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
