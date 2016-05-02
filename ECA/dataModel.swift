//
//  dataModel.swift
//  ECA
//
//  Created by Mohamed Lee on 20.04.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import Foundation

protocol DataDelegate {
    func eventHasBeenRetreive(events:[basicEvent])
}

protocol eventType {
    var date: NSDate { get }
    var jourChiffreToDisplay: String { get }
    var jourLettreToDisplay: String { get }
    var heureToDisplay: String { get }
    var moisToDisplay: String { get }
    var location: String { get }
    var description: String { get }
    
    func shortDescription() -> String
}

class basicEvent:eventType {
    let dateFormatter = NSDateFormatter()
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    var date:NSDate
    var jourChiffreToDisplay:String {
        dateFormatter.dateFormat = Reference.heureFormat
        return dateFormatter.stringFromDate(date)
    }
    var jourLettreToDisplay: String {
        var weekDay:Int?
        if let myCalendar = calendar{
            let myWeekComponents = myCalendar.components(.Weekday, fromDate: date)
            weekDay = myWeekComponents.weekday
        }
        if let weekDayUnwrapped = weekDay, jourEnLettre = dayOfWeek(rawValue: weekDayUnwrapped) {
            return jourEnLettre.description()
        } else {
            return ""
        }
    }
    
    var moisToDisplay: String {
        var month:Int?
        if let myCalendar = calendar{
            let myMonthComponents = myCalendar.component(.Month, fromDate: date)
            month = myMonthComponents.hashValue
        }
        if let monthUnwrapped = month, moisEnLettre = monthOfYear(rawValue: monthUnwrapped){
            return moisEnLettre.description()
        } else {
            return ""
        }
    }
    var heureToDisplay: String {
        let hours = NSCalendar.currentCalendar().component(.Hour, fromDate: date)
        let minutes = NSCalendar.currentCalendar().component(.Minute, fromDate: date)
        if minutes == 0 {
            return "\(hours)h\(minutes)0"
        } else if minutes < 10 {
            return "\(hours)h0\(minutes)"
        } else {
            return "\(hours)h\(minutes)"
        }
    }
    
    
    var location: String
    var description: String
    
    init(lieu:String, date:NSDate, description: String){
        self.location = lieu
        self.date = date
        self.description = description
    }
    
    func shortDescription() -> String {
        return "\(jourChiffreToDisplay) \(jourLettreToDisplay) \(moisToDisplay) \(heureToDisplay) \(location) \(description)"
    }
}

class DataTransfert {
    
    var delegate:DataDelegate?
    var events = [basicEvent]()
    
    let dateFormatter = NSDateFormatter()
    
    private func convertDate(date: String) -> NSDate? {
        dateFormatter.dateFormat = Reference.dateHeureFormat
        return dateFormatter.dateFromString(date)
    }
    
    //TODO: pouvoir en stocker une certaine quantité en local
    func retrieveData(){
        //TODO: si une donnée est corrompue, pouvoir afficher le reste quand même
        Reference.firebaseEvents.observeEventType(.ChildAdded, withBlock: { snapshot in
            if let  description = snapshot.value.objectForKey(Reference.ecaDescription) as? String,
                    lieu = snapshot.value.objectForKey(Reference.ecaLieu) as? String,
                    tempJour = snapshot.value.objectForKey(Reference.ecaJour) as? String{
                if let tempDay = self.convertDate(tempJour){
                    let tempEvent = basicEvent(lieu: lieu, date: tempDay, description: description)
                    self.events.append(tempEvent)
                    self.delegate?.eventHasBeenRetreive(self.events)
                } else {
                    //TODO: Throw error and manage.
                }
            }
        })
    }
}

//                let jeudi21 = ["date":"21.04.2016 19:04","description":"Soirée Bhajans et chants du coeur, avec Luc Raimondi","lieu":"espace culturel","intervenant":"Luc Raimondi"]
//                let samedi23 = ["date":"23.04.2016 15:00","description":"Spectacle Mémoires partagées: dans le prolongement de la Semaine d'actions contre le Racisme, des femmes de tout horizon partagent leurs histoires en paroles et en chants, accompagnées d'Emilie Vuissoz et de Pauline Lugon.","lieu":"espace culturel","intervenant":""]
//                let jeudi28 = ["date":"28.04.2016 20:00","description":"Conférence de David Drayer: Le Farinet, monnaie locale","lieu":"espace culturel","intervenant":""]
//
//                let eventsRef = Reference.firebaseRoot.childByAppendingPath(Reference.ecaEvent)
//
//                let events = ["jeudi21": jeudi21, "samedi23": samedi23, "jeudi28": jeudi28]
//                eventsRef.setValue(events)



