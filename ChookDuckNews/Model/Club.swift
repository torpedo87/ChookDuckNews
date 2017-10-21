//
//  Club.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 20..
//  Copyright © 2017년 samchon. All rights reserved.
//

import Foundation

struct League {
  init(title: String, url: String) {
    name = title
    leagueURL = url
  }
  var name: String!
  var clubs: [Club]?
  var leagueURL: String!
  
}

struct Club {
  var name: String!
}
