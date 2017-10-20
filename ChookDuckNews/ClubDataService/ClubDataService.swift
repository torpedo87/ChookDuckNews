//
//  ClubDataService.swift
//  ChookDuckNews
//
//  Created by junwoo on 2017. 10. 20..
//  Copyright © 2017년 samchon. All rights reserved.
//

import Foundation

class ClubDataService {
  
  static let instance = ClubDataService()
  
  var selectedClub: Club?
  
  var countries: [Country] = [England, Spain, France, Italy]
  
}
