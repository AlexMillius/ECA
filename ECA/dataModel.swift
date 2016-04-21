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
    var date:NSDate? { get }
    var time:NSDate? { get }
    var location:String { get }
    var people:String? { get }
    var description:String { get }
    
    func shortDescription() -> String
}

class basicEvent:eventType {
    var date: NSDate? {
        return convertDate(jour)
    }
    var jour: String
    var time: NSDate?  {
        return convertTime(heure)
    }
    var heure:String
    var location: String
    var people:String?
    var description: String
    
    init(jour:String, heure:String, lieu:String, description: String, people: String){
        self.jour = jour
        self.heure = heure
        self.location = lieu
        self.description = description
        self.people = people
    }
    
    let dateFormatter = NSDateFormatter()
    
    private func convertDate(date: String) -> NSDate? {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.dateFromString(date)
    }
    
    private func convertTime(time:String) -> NSDate? {
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.dateFromString(time)
    }
    
    
    
    func shortDescription() -> String {
        return "\(jour) \(heure) \(location) \(description)"
    }
}

class DataTransfert {
    
    var delegate:DataDelegate?
    var events = [basicEvent]()
    
    //        let jeudi21 = ["date":"21.04.2016","heure":"19h30","description":"Soirée Bhajans et chants du coeur, avec Luc Raimondi","lieu":"espace culturel","intervenant":"Luc Raimondi"]
    //        let samedi23 = ["date":"23.04.2016","heure":"20h00","description":"Spectacle Mémoires partagées: dans le prolongement de la Semaine d'actions contre le Racisme, des femmes de tout horizon partagent leurs histoires en paroles et en chants, accompagnées d'Emilie Vuissoz et de Pauline Lugon.","lieu":"espace culturel","intervenant":""]
    //
    //        let eventsRef = Reference.firebaseRoot.childByAppendingPath(Reference.ecaEvent)
    //
    //        let events = ["jeudi21": jeudi21, "samedi23": samedi23]
    //        eventsRef.setValue(events)
    
    func retrieveData(){
        Reference.firebaseEvents.observeEventType(.ChildAdded, withBlock: { snapshot in
            if let  description = snapshot.value.objectForKey(Reference.ecaDescription) as? String,
                    lieu = snapshot.value.objectForKey(Reference.ecaLieu) as? String,
                    date = snapshot.value.objectForKey(Reference.ecaJour) as? String,
                    heure = snapshot.value.objectForKey(Reference.ecaHeure) as? String,
                    intervenant = snapshot.value.objectForKey(Reference.ecaIntervenant) as? String{
                
                let tempEvent = basicEvent(jour: date, heure: heure, lieu: lieu, description: description, people: intervenant)
                self.events.append(tempEvent)
                self.delegate?.eventHasBeenRetreive(self.events)
            }
        })
    }
}



