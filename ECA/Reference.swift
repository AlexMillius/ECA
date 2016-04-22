//
//  Reference.swift
//  ECA
//
//  Created by Mohamed Lee on 21.04.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import Foundation
import Firebase
import UIKit

struct Reference {
    static let firebaseRoot = Firebase(url: "https://eca.firebaseio.com")
    static let firebaseEvents = Firebase(url: "https://eca.firebaseio.com/events")
    static let tableViewCell = "basic cell"
    static let ecaEvent = "events"
    static let ecaHeure = "heure"
    static let ecaJour = "date"
    static let ecaDescription = "description"
    static let ecaIntervenant   = "intervenant"
    static let ecaLieu = "lieu"
    static let detailSegueIdentifier = "detailViewSegue"
    static let estimatedRowHeight:CGFloat = 160.0
    static let dateHeureFormat = "dd.MM.yyyy HH:mm"
    static let heureFormat = "dd"
}

enum tagTblView:Int {
    case date = 1
    case description
}

enum dayOfWeek:Int {
    case dimanche = 1,lundi,mardi,mercredi,jeudi,vendredi,samedi
    
    func description()->String{
        switch self.rawValue {
        case 1: return "dimanche"
        case 2: return "lundi"
        case 3: return "mardi"
        case 4: return "mercredi"
        case 5: return "jeudi"
        case 6: return "vendredi"
        case 7: return "samedi"
        default: return ""
        }
    }
}

enum monthOfYear:Int{
    case janvier = 1, février, mars, avril, mai, juin, juillet, août, septembbre, octobre, novembre, décembre
    func description()->String{
        switch self.rawValue {
        case 1: return "janvier"
        case 2: return "février"
        case 3: return "mars"
        case 4: return "avril"
        case 5: return "mai"
        case 6: return "juin"
        case 7: return "juillet"
        case 8: return "août"
        case 9: return "septembre"
        case 10: return "octobre"
        case 11: return "novembre"
        case 12: return "décembre"
        default: return ""
        }
    }
}

