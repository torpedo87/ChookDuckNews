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
  var tempSquad = [String]()
  
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
          let newClub = Club.init(title: a.stringValue)
          tempclubs.append(newClub)
        }
      }
      completion(tempclubs)
      
    } catch {
      completion([])
      print("error: ", error.localizedDescription)
    }
  }
  
  func fetchSquad(club: Club, completion: @escaping (_ players: [String]) -> Void) {
    tempSquad.removeAll()
    
    var html = ""
    let toArray = club.name.components(separatedBy: " ")
    let newUrl = toArray.joined(separator: "-").lowercased()
    
    var squadURL = "http://www.skysports.com/\(newUrl)-squad"
    
    do {
      html = try String(contentsOf: URL(string: squadURL)!)
      
    } catch {
      print(error.localizedDescription)
    }
    
    do {
      let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
      
      for h6 in doc.css("h6") {
        tempSquad.append(h6.stringValue)
        
      }
      completion(tempSquad)
      
    } catch {
      completion([])
      print("error: ", error.localizedDescription)
    }
  }
}
