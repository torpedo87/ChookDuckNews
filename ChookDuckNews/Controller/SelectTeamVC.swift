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
  var spinner = UIActivityIndicatorView()
  var topView = UIView()
  var topLabel = UILabel()
  var backButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    spinner.isHidden = true
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(TeamCell.self, forCellReuseIdentifier: "teamCell")
    
    view.addSubview(topView)
    topView.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
    topView.addSubview(topLabel)
    topLabel.text = "Choose one Team"
    topLabel.textAlignment = .center
    topLabel.textColor = UIColor.white
    topView.addSubview(backButton)
    backButton.setTitle("Back", for: .normal)
    backButton.setTitleColor(UIColor.white, for: .normal)
    backButton.addTarget(self, action: #selector(SelectTeamVC.backBtnPressed), for: .touchUpInside)
    view.addSubview(tableView)
    view.addSubview(spinner)
  }
  
  @objc func backBtnPressed() {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    topView.snp.makeConstraints { (make) in
      make.left.top.right.equalTo(self.view)
      make.height.equalTo(70)
    }
    topLabel.snp.makeConstraints { (make) in
      make.center.equalTo(topView)
      make.width.equalTo(200)
      make.height.equalTo(50)
    }
    backButton.snp.makeConstraints { (make) in
      make.width.height.equalTo(50)
      make.left.equalTo(topView).offset(2)
      make.centerY.equalTo(topView)
    }
    tableView.snp.makeConstraints { (make) in
      make.left.bottom.right.equalTo(self.view)
      make.top.equalTo(topView.snp.bottom)
    }
    
    spinner.snp.makeConstraints { (make) in
      make.width.height.equalTo(100)
      make.center.equalTo(self.view)
    }
  }
}

extension SelectTeamVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    spinner.isHidden = false
    spinner.startAnimating()
    
    guard let clubs = ClubDataService.instance.leagues[indexPath.section].clubs as? [Club] else { return }
    let club = clubs[indexPath.row] as Club
    DataService.instance.selectedClub = club
    UserDefaults.init(suiteName: "group.chookduck.samchon")?.setValue(club.name, forKey: "myClub")
    NotificationCenter.default.post(name: NOTI_CLUB_CHANGED, object: nil)
    dismiss(animated: true) {
      self.spinner.isHidden = true
      self.spinner.stopAnimating()
    }
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
