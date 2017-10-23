//
//  Constant.swift
//  ChookDuck Widget
//
//  Created by junwoo on 2017. 10. 18..
//  Copyright © 2017년 samchon. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//기사 갯수
let NEWS_LIMIT: Int = 7

//리그

var epl = League.init(title: "epl", url: "http://www.skysports.com/premier-league-table")
var primera = League.init(title: "primera", url: "http://www.skysports.com/la-liga-table")
var bundesliga = League.init(title: "bundesliga", url: "http://www.skysports.com/bundesliga-table")
var seria = League.init(title: "seria", url: "http://www.skysports.com/serie-a-table")
var ligue1 = League.init(title: "ligue1", url: "http://www.skysports.com/ligue-1-table")

//notification
let NOTI_CLUB_CHANGED = Notification.Name("selectedClubChanged")
