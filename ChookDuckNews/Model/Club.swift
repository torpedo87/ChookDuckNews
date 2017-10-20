//
//  Club.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 20..
//  Copyright © 2017년 samchon. All rights reserved.
//

import Foundation

struct Country {
  var name: String!
  var league: [Club]!
}

struct Club {
  var name: String!
  
  var clubURL: String {
    get {
      return "https://news.google.com/search/section/q/\(name)/\(name)?hl=ko&ned=kr"
    }
  }
  
}
