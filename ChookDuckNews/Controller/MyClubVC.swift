//
//  MyClubVC.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 21..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit

class MyClubVC: UIViewController {
  
  var titleLabel = UILabel()
  var nameLabel = UILabel()
  var myTeamLabel = UILabel()
  var myPlayerLabel = UILabel()
  var selectTeamBtn = UIButton()
  var topView = UIView()
  var topLabel = UILabel()
  var imgView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    selectTeamBtn.isEnabled = false
    setupView()
    NotificationCenter.default.addObserver(self, selector: #selector(MyClubVC.redraw), name: NOTI_CLUB_CHANGED, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(MyClubVC.redraw), name: NOTI_PLAYER_CHANGED, object: nil)
    fetchClubs { (success) in
      if success {
        self.selectTeamBtn.isEnabled = true
      }
    }
  }
  
  func setupView() {
    view.backgroundColor = UIColor.white
    view.addSubview(topView)
    topView.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
    topView.addSubview(topLabel)
    topLabel.text = "MY TEAM"
    topLabel.textColor = UIColor.white
    topLabel.textAlignment = .center
    view.addSubview(titleLabel)
    view.addSubview(nameLabel)
    view.addSubview(myTeamLabel)
    view.addSubview(myPlayerLabel)
    view.addSubview(selectTeamBtn)
    view.addSubview(imgView)
    imgView.image = UIImage(named: "uniform")
    selectTeamBtn.setTitle("SELECT", for: .normal)
    selectTeamBtn.addTarget(self, action: #selector(MyClubVC.goToSelectTeamVC), for: .touchUpInside)
    selectTeamBtn.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
    
    if let myTeamName = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myClub") as? String {
      myTeamLabel.text = myTeamName
      DataService.instance.selectedClub = Club(title: myTeamName)
    } else {
      myTeamLabel.text = "미정"
    }
    
    if let myPlayer = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myPlayer") as? String {
      myPlayerLabel.text = myPlayer
      DataService.instance.selectedPlayer = myPlayer
    } else {
      myPlayerLabel.text = "미정"
    }
    
    titleLabel.text = "MY TEAM : "
    titleLabel.font = UIFont(name: "Avenir", size: 25)
    myTeamLabel.font = UIFont(name: "Avenir", size: 25)
    nameLabel.text = "MY PLAYER : "
    nameLabel.font = UIFont(name: "Avenir", size: 25)
    myPlayerLabel.font = UIFont(name: "Avenir", size: 25)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    titleLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(self.view)
      make.height.equalTo(50)
      make.width.equalTo(150)
      make.left.equalTo(self.view).offset(30)
    }
    
    nameLabel.snp.makeConstraints { (make) in
      make.width.height.equalTo(titleLabel)
      make.top.equalTo(titleLabel.snp.bottom).offset(5)
      make.centerX.equalTo(titleLabel)
    }
    
    myTeamLabel.snp.makeConstraints { (make) in
      make.left.equalTo(titleLabel.snp.right).offset(10)
      make.centerY.equalTo(self.view)
      make.height.equalTo(50)
      make.width.equalTo(200)
    }
    
    myPlayerLabel.snp.makeConstraints { (make) in
      make.width.height.equalTo(myTeamLabel)
      make.top.equalTo(myTeamLabel.snp.bottom).offset(5)
      make.centerX.equalTo(myTeamLabel)
    }
    
    selectTeamBtn.snp.makeConstraints { (make) in
      make.height.equalTo(50)
      make.width.equalTo(150)
      make.centerX.equalTo(self.view)
      make.top.equalTo(nameLabel.snp.bottom).offset(30)
    }
    
    topView.snp.makeConstraints { (make) in
      make.left.top.right.equalTo(self.view)
      make.height.equalTo(70)
    }
    topLabel.snp.makeConstraints { (make) in
      make.center.equalTo(topView)
      make.width.equalTo(300)
      make.height.equalTo(50)
    }
    imgView.snp.makeConstraints { (make) in
      make.centerX.equalTo(self.view)
      make.top.equalTo(topView.snp.bottom).offset(30)
      make.width.height.equalTo(170)
    }
  }
  
  func fetchClubs(completion: @escaping CompletionHandler) {
    for i in 0..<ClubDataService.instance.leagues.count {
      ClubDataService.instance.fetchClub(league: ClubDataService.instance.leagues[i], completion: { (clubs) in
        ClubDataService.instance.leagues[i].clubs = clubs
        if i == ClubDataService.instance.leagues.count - 1 {
          completion(true)
        }
      })
    }
  }
  
  @objc func goToSelectTeamVC() {
    let selectTeamVC = SelectTeamVC()
    present(UINavigationController(rootViewController: selectTeamVC), animated: true, completion: nil)
  }
  
  @objc func redraw() {
    if let myTeamName = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myClub") as? String {
      myTeamLabel.text = myTeamName
      DataService.instance.selectedClub = Club(title: myTeamName)
      selectTeamBtn.setTitle("Change Team", for: .normal)
    } else {
      myTeamLabel.text = "미정"
    }
    
    if let myPlayer = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myPlayer") as? String {
      myPlayerLabel.text = myPlayer
    } else {
      myPlayerLabel.text = "미정"
    }
  }
}
