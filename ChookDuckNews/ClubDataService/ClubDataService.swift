//
//  ClubDataService.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 20..
//  Copyright © 2017년 samchon. All rights reserved.
//

import Foundation
import Fuzi

class ClubDataService {
  
  static let instance = ClubDataService()
  
  var tempclubs = [Club]()
  
  var leagues: [League] = [epl, primera, bundesliga, seria, ligue1]
  
  func fetchClub(league: League, completion: @escaping (_ newClubs: [Club]) -> Void) {
    
    tempclubs.removeAll()
    
    var html = ""
    do {
      html = try String(contentsOf: URL(string: league.leagueURL)!)
      //print("url=======", league.leagueURL)
    } catch {
      print(error.localizedDescription)
    }
    
    do {
      let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
      
      for a in doc.css("a") {
        if let aClass = a["class"], aClass == "standing-table__cell--name-link" {
          var newClub = Club.init(name: a.stringValue)
          tempclubs.append(newClub)
        }
      }
      completion(tempclubs)
      
    } catch {
      completion([])
      print("error: ", error.localizedDescription)
    }
  }
}
