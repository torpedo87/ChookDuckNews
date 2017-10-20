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
let NEWS_LIMIT: Int = 6

//club
let ManUtd = Club.init(name: "ManUtd")
let Chelsea = Club.init(name: "Chelsea")
let Arsenal = Club.init(name: "Arsenal")
let ManCity = Club.init(name: "ManCity")
let Tottenham = Club.init(name: "Tottenham")
let PSG = Club.init(name: "PSG")
let Juventus = Club.init(name: "Juventus")
let RealMadrid = Club.init(name: "RealMadrid")
let Barcelona = Club.init(name: "Barcelona")

//나라
let England = Country.init(name: "England", league: [ManUtd, Chelsea, Arsenal, ManCity, Tottenham])
let France = Country.init(name: "France", league: [PSG])
let Italy = Country.init(name: "Italy", league: [Juventus])
let Spain = Country.init(name: "Spain", league: [RealMadrid, Barcelona])

//notification
let NOTI_CLUB_CHANGED = Notification.Name("selectedClubChanged")
