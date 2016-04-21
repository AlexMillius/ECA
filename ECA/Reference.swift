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
}