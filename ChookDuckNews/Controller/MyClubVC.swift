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
  var myTeamLabel = UILabel()
  var selectTeamBtn = UIButton()
  var spinner = UIActivityIndicatorView()
  var topView = UIView()
  var topLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    view.addSubview(topView)
    topView.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
    topView.addSubview(topLabel)
    topLabel.text = "My Team"
    topLabel.textColor = UIColor.white
    topLabel.textAlignment = .center
    view.addSubview(titleLabel)
    view.addSubview(myTeamLabel)
    view.addSubview(selectTeamBtn)
    view.addSubview(spinner)
    spinner.isHidden = true
    
    NotificationCenter.default.addObserver(self, selector: #selector(MyClubVC.redraw), name: NOTI_CLUB_CHANGED, object: nil)
    
    if let myTeamName = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myClub") as? String {
      myTeamLabel.text = myTeamName
      DataService.instance.selectedClub = Club(name: myTeamName)
      selectTeamBtn.setTitle("Change Team", for: .normal)
    } else {
      myTeamLabel.text = "미정"
      selectTeamBtn.setTitle("Add Team", for: .normal)
    }
    selectTeamBtn.addTarget(self, action: #selector(MyClubVC.goToSelectTeamVC), for: .touchUpInside)
    selectTeamBtn.backgroundColor = UIColor.blue
    titleLabel.text = "my Team : "
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    titleLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(self.view)
      make.height.equalTo(50)
      make.width.equalTo(100)
      make.left.equalTo(self.view).offset(30)
    }
    
    myTeamLabel.snp.makeConstraints { (make) in
      make.left.equalTo(titleLabel.snp.right).offset(10)
      make.centerY.equalTo(self.view)
      make.height.equalTo(50)
      make.width.equalTo(200)
    }
    
    selectTeamBtn.snp.makeConstraints { (make) in
      make.height.equalTo(50)
      make.width.equalTo(150)
      make.centerX.equalTo(self.view)
      make.top.equalTo(titleLabel.snp.bottom).offset(30)
    }
    
    spinner.snp.makeConstraints { (make) in
      make.width.height.equalTo(100)
      make.center.equalTo(self.view)
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
  }
  
  @objc func goToSelectTeamVC() {
    spinner.isHidden = false
    spinner.startAnimating()
    
    let selectTeamVC = SelectTeamVC()
    present(selectTeamVC, animated: true) {
      self.spinner.isHidden = true
      self.spinner.stopAnimating()
    }
  }
  
  @objc func redraw() {
    if let myTeamName = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myClub") as? String {
      myTeamLabel.text = myTeamName
      DataService.instance.selectedClub = Club(name: myTeamName)
      selectTeamBtn.setTitle("Change Team", for: .normal)
    } else {
      myTeamLabel.text = "미정"
      selectTeamBtn.setTitle("Add Team", for: .normal)
    }
  }
}
