//
//  Reference.swift
//  ECA
//
//  Created by Mohamed Lee on 21.04.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import Foundation
import Firebase

struct Reference {
    static let firebaseRoot = Firebase(url: "https://eca.firebaseio.com")
    static let firebaseEvents = Firebase(url: "https://eca.firebaseio.com/events")
    static let tableViewCell = "basic cell"
    static let ecaEvent = "events"
    static let ecaHeure = "heure"
    static let ecaJour = "date"
    static let ecaDescription = "description"
    static let ecaIntervenant = "intervenant"
    static let ecaLieu = "lieu"
    static let detailSegueIdentifier = "detailViewSegue"
}

enum tagTblView:Int {
    case date = 1
    case heure
    case description
}




