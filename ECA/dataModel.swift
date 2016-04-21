//
//  dataModel.swift
//  ECA
//
//  Created by Mohamed Lee on 20.04.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import Foundation

protocol eventType {
    var name:String { get }
    var date:NSDate { get }
    var time:NSDate { get }
    var location:String { get }
    var people:String? { get }
    var description:String { get }
    
    func shortDescription() -> String
}

class basicEvent:eventType {
    var name: String
    var date: NSDate
    var jour: String{
        return convertDate(date)
    }
    var time: NSDate
    var heure:String {
        return convertTime(time)
    }
    var location: String
    var people:String?
    var description: String
    
    init(nom:String, date:NSDate, heure:NSDate, lieu:String, description: String){
        self.name = nom
        self.date = date
        self.time = heure
        self.location = lieu
        self.description = description
    }
    
    let dateFormatter = NSDateFormatter()
    
    private func convertDate(date: NSDate) -> String {
        dateFormatter.dateFormat = "dd.MM"
        // TODO: pouvoir retourner lundi-mardi-mercredi janvier-février
        return dateFormatter.stringFromDate(date)
    }
    
    private func convertTime(time:NSDate) -> String {
        dateFormatter.dateFormat = "hh:mm"
        // TODO: retourner 20h15
        return dateFormatter.stringFromDate(time)
    }
    
    func shortDescription() -> String {
        return "\(name) \(jour) \(heure) \(location)"
    }
}

class DataTransfert {
    let eventRef = Reference.firebaseEvents
    
    func retrieveDataOnce(){
        eventRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            print(snapshot.value.objectForKey("jeudi21"))
            print(snapshot.value.objectForKey("location"))
        })
    }
}



