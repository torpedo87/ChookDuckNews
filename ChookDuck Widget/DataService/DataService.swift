//
//  DataService.swift
//  ChookDuck Widget
//
//  Created by junwoo on 2017. 10. 18..
//  Copyright © 2017년 samchon. All rights reserved.
//

import Foundation
import Fuzi

class DataService {
  static let instance = DataService()
  
  var clubArticles = [Article]()
  var playerArticles = [Article]()
  var selectedClub: Club?
  var selectedPlayer: String?
  
  func fetchClubFeed(completion: @escaping CompletionHandler) {
    
    clubArticles.removeAll()
    
    var urlString = ""
    if let name: String = selectedClub?.name {
      let noSpaceName = name.removingWhitespaces()
      urlString = "https://news.google.com/news/search/section/q/\(noSpaceName)/\(noSpaceName)?hl=ko&ned=kr"
    } else {
      urlString = "https://news.google.com/news/search/section/q/manchesterunited/manchesterunited?hl=ko&ned=kr"
    }
    
    var html = ""
    do {
      html = try String(contentsOf: URL(string: urlString)!)
    } catch {
      print(error.localizedDescription)
    }
    
    do {
      let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
      
      for div in doc.css("div") {
        var title = ""
        var url = ""
        var imgSrc: String?
        
        if let article = div["class"], article == "qx0yFc" {
          
          
          if let img = div.css("img").first, img["class"] == "lmFAjc" {
            imgSrc = img["src"]
            //print("imgSrc", imgSrc)
          }
          
          for a in div.css("a") {
            if let classes = a["class"], classes == "nuEeue hzdq5d ME7ew", a["aria-level"] == "2" {
              title = a.stringValue
              url = a["href"]!
            }
          }
          let newArticle = Article(articleTitle: title, articleUrl: url, articleImg: imgSrc)
          clubArticles.append(newArticle)
        }
        if clubArticles.count == NEWS_LIMIT {
          completion(true)
        }
      }
      
    } catch {
      completion(false)
      print("error: ", error.localizedDescription)
    }
    
  }
  
  func fetchPlayerFeed(completion: @escaping CompletionHandler) {
    
    playerArticles.removeAll()
    
    var urlString = ""
    if let name: String = selectedPlayer {
      let noSpaceName = name.removingWhitespaces()
      urlString = "https://news.google.com/news/search/section/q/\(noSpaceName)/\(noSpaceName)?hl=ko&ned=kr"
    } else {
      urlString = "https://news.google.com/news/search/section/q/manchesterunited/manchesterunited?hl=ko&ned=kr"
    }
    
    var html = ""
    do {
      html = try String(contentsOf: URL(string: urlString)!)
    } catch {
      print(error.localizedDescription)
    }
    
    do {
      let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
      
      for div in doc.css("div") {
        var title = ""
        var url = ""
        var imgSrc: String?
        
        if let article = div["class"], article == "qx0yFc" {
          
          
          if let img = div.css("img").first, img["class"] == "lmFAjc" {
            imgSrc = img["src"]
            //print("imgSrc", imgSrc)
          }
          
          for a in div.css("a") {
            if let classes = a["class"], classes == "nuEeue hzdq5d ME7ew", a["aria-level"] == "2" {
              title = a.stringValue
              url = a["href"]!
            }
          }
          let newArticle = Article(articleTitle: title, articleUrl: url, articleImg: imgSrc)
          playerArticles.append(newArticle)
        }
        if playerArticles.count == NEWS_LIMIT {
          completion(true)
        }
      }
      
    } catch {
      completion(false)
      print("error: ", error.localizedDescription)
    }
    
  }
}

extension String {
  func removingWhitespaces() -> String {
    return components(separatedBy: .whitespaces).joined()
  }
}
