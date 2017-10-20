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
  
  var articles = [Article]()
  
  func fetchFeed(completion: @escaping CompletionHandler) {
    
    articles.removeAll()
    
    var html = ""
    do {
      html = try String(contentsOf: URL(string: (ClubDataService.instance.selectedClub?.clubURL)!)!)
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
              print("title : ", title, ", url : ", url)
            }
          }
          let newArticle = Article(articleTitle: title, articleUrl: url, articleImg: imgSrc)
          articles.append(newArticle)
        }
        if articles.count == NEWS_LIMIT {
          completion(true)
        }
      }
      
    } catch {
      completion(false)
      print("error: ", error.localizedDescription)
    }
    
  }
}
