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
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var playerTableView: UITableView!
  @IBOutlet weak var clubTableView: UITableView!
  var isPlayerTableViewShowing = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    playerTableView.isHidden = true
    if let clubName = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myClub") as? String {
      DataService.instance.selectedClub = Club(title: clubName)
    }
    if let player = UserDefaults.init(suiteName: "group.chookduck.samchon")?.value(forKey: "myPlayer") as? String {
      DataService.instance.selectedPlayer = player
    }
    
    clubTableView.delegate = self
    clubTableView.dataSource = self
    playerTableView.delegate = self
    playerTableView.dataSource = self
    
    NotificationCenter.default.addObserver(self, selector: #selector(TodayViewController.redrawClubNews(_:)), name: NOTI_CLUB_CHANGED, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(TodayViewController.redrawPlayerNews(_:)), name: NOTI_PLAYER_CHANGED, object: nil)
    
    extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    
    DataService.instance.fetchClubFeed() { (success) in
      if success {
        self.clubTableView.reloadData()
      }
    }
    
    DataService.instance.fetchPlayerFeed() { (success) in
      if success {
        self.playerTableView.reloadData()
      }
    }
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
  }
  
  @objc func redrawClubNews(_ notification: Notification) {
    
    DataService.instance.fetchClubFeed() { (success) in
      if success {
        self.clubTableView.reloadData()
      }
    }
  }
  
  @objc func redrawPlayerNews(_ notification: Notification) {
    
    DataService.instance.fetchPlayerFeed() { (success) in
      if success {
        self.playerTableView.reloadData()
      }
    }
  }
  
  @objc func clubDidTap(_ gesture: UITapGestureRecognizer) {
    
  }
  
  //위젯이 업데이트 될 때까지 최근 스냅샷을 제공
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {

  }
  
  //위젯 높이 조절
  func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
    let expanded = activeDisplayMode == .expanded
    preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 520) : maxSize
  }
  
  @IBAction func reloadBtnPressed(_ sender: Any) {
    if isPlayerTableViewShowing {
      
      UIView.transition(from: playerTableView,
                        to: clubTableView,
                        duration: 1.0,
                        options: [.transitionFlipFromLeft, .showHideTransitionViews],
                        completion:nil)
    } else {
      
      UIView.transition(from: clubTableView,
                        to: playerTableView,
                        duration: 1.0,
                        options: [.transitionFlipFromRight, .showHideTransitionViews],
                        completion: nil)
    }
    isPlayerTableViewShowing = !isPlayerTableViewShowing
  }
}

extension TodayViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if tableView == clubTableView {
      guard let url = URL(string: DataService.instance.clubArticles[indexPath.row].articleUrl) else { return }
      
      extensionContext?.open(url, completionHandler: nil)
    } else {
      guard let url = URL(string: DataService.instance.playerArticles[indexPath.row].articleUrl) else { return }
      
      extensionContext?.open(url, completionHandler: nil)
    }

  }
}

extension TodayViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == clubTableView {
      return DataService.instance.clubArticles.count
    } else {
      return DataService.instance.playerArticles.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCell {
      if tableView == clubTableView {
        cell.configureClubCell(index: indexPath.row)
      } else {
        cell.configurePlayerCell(index: indexPath.row)
      }
      cell.checkBtndelegate = self
      return cell
    }
    
    return CustomCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
}

extension TodayViewController: CheckBtnDelegate {
  func checkBtnDidTap(sender: UIButton) {
    sender.isSelected = !sender.isSelected
    if sender.isSelected {
      if let cell = sender.superview?.superview as? CustomCell {
        if cell.superview == clubTableView {
          let indexPath = clubTableView.indexPath(for: cell)
          DataService.instance.clubArticles.remove(at: (indexPath?.row)!)
          clubTableView.reloadData()
        } else {
          let indexPath = playerTableView.indexPath(for: cell)
          DataService.instance.playerArticles.remove(at: (indexPath?.row)!)
          playerTableView.reloadData()
        }
        
      }
    }
  }
}
