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
    var date:NSDate { get }
    var jourToDisplay:String { get }
    var heureToDisplay:String { get }
    var location:String { get }
    var description:String { get }
    
    func shortDescription() -> String
}

class basicEvent:eventType {
    let dateFormatter = NSDateFormatter()
    var date: NSDate
    var jourToDisplay:String {
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(date)
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
        return "\(jourToDisplay) \(heureToDisplay) \(location) \(description)"
    }
}

class DataTransfert {
    
    var delegate:DataDelegate?
    var events = [basicEvent]()
    
    let dateFormatter = NSDateFormatter()
    
    private func convertDate(date: String) -> NSDate? {
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.dateFromString(date)
    }
    
    func retrieveData(){
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


//        let jeudi21 = ["date":"21.04.2016","heure":"19h30","description":"Soirée Bhajans et chants du coeur, avec Luc Raimondi","lieu":"espace culturel","intervenant":"Luc Raimondi"]
//        let samedi23 = ["date":"23.04.2016","heure":"20h00","description":"Spectacle Mémoires partagées: dans le prolongement de la Semaine d'actions contre le Racisme, des femmes de tout horizon partagent leurs histoires en paroles et en chants, accompagnées d'Emilie Vuissoz et de Pauline Lugon.","lieu":"espace culturel","intervenant":""]
//
//        let eventsRef = Reference.firebaseRoot.childByAppendingPath(Reference.ecaEvent)
//
//        let events = ["jeudi21": jeudi21, "samedi23": samedi23]
//        eventsRef.setValue(events)


