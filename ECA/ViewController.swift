//
//  ViewController.swift
//  ECA
//
//  Created by Mohamed Lee on 20.04.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataDelegate{
    
    @IBOutlet weak var eventTableView: UITableView!
    
    var events = [basicEvent]()
    var currentDate: NSDate?
    var currentDescription: String? //TODO: delete
    let dataTransfert = DataTransfert()
    var numberOfMonthToDisplay = Int()
    var numberOfEventInEachSection = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        dataTransfert.delegate = self
        dataTransfert.retrieveData()
        
        
//                let jeudi21 = ["date":"21.04.2016 19:04","description":"Soirée Bhajans et chants du coeur, avec Luc Raimondi","lieu":"espace culturel","intervenant":"Luc Raimondi"]
//                let samedi23 = ["date":"23.04.2016 15:00","description":"Spectacle Mémoires partagées: dans le prolongement de la Semaine d'actions contre le Racisme, des femmes de tout horizon partagent leurs histoires en paroles et en chants, accompagnées d'Emilie Vuissoz et de Pauline Lugon.","lieu":"espace culturel","intervenant":""]
//                let jeudi28 = ["date":"28.04.2016 20:00","description":"Conférence de David Drayer: Le Farinet, monnaie locale","lieu":"espace culturel","intervenant":""]
//        
//                let eventsRef = Reference.firebaseRoot.childByAppendingPath(Reference.ecaEvent)
//        
//                let events = ["jeudi21": jeudi21, "samedi23": samedi23, "jeudi28": jeudi28]
//                eventsRef.setValue(events)
    }
    
    override func viewWillAppear(animated: Bool) {
        //TODO: mettre ici le dataTransfert.retrieveData quand j'aurai enlever la detailVue
    }
    
    func eventHasBeenRetreive(events: [basicEvent]) {
        self.events = events
        
        
        getNumberOfMonthToDisplay(events)
        
        
        eventTableView.reloadData()
    }
    
    // calcul combien il y a de mois afin de pouvoir séparer les chapitres dans la tableView
    // calcul combien il y a d'events par mois pour séparer les header de la tableView
    // pour le nombre de mois (numberOfMonthToDisplay) la variable tempRefMois et le numberOfMonthToDisplay sont initialisés. on loop les events. Chaque fois que le nom d'un event.moisToDisplay (par exemple avril) n'est pas identique à la tempRefMois, on incrémente le numberOfMonthToDisplay. Pour terminer, on affecte le nom du .moisToDisplay actuel à la tempRefMois pour la prochaine boucle.
    func getNumberOfMonthToDisplay(events: [basicEvent]){
        var tempRefMois = String()
        
        var tempNbInSection = Int()
        //print("tempNbInSection init: \(tempNbInSection)")
        var currentMonth = String()
        var lastMonth = String()
        var count = 0
        numberOfMonthToDisplay = Int()
        //print("number reinit to 0: \(numberOfMonthToDisplay)")
        numberOfEventInEachSection = [Int]()
        for event in events {
            // implémentation pour nb de mois
            if tempRefMois != event.moisToDisplay {
                numberOfMonthToDisplay += 1
                //print("number incremented \(numberOfMonthToDisplay)")
                tempRefMois = event.moisToDisplay
            }
            // implémentation pour nb de section par mois
            count += 1
            currentMonth = event.moisToDisplay
            if lastMonth != currentMonth {
                tempNbInSection += 1
                //print("tempNbInSection: \(tempNbInSection)")
                if count == events.count {
                    numberOfEventInEachSection.append(tempNbInSection)
                    //print("numberSectionArray: \(numberOfEventInEachSection)")
                    tempNbInSection = 0
                }
            } else {
                numberOfEventInEachSection.append(tempNbInSection)
                //print("numberSectionArray: \(numberOfEventInEachSection)")
                tempNbInSection = 1
                lastMonth = currentMonth
            }
            
        }
    }
    
    //MARK: tableView delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("events.count: \(events.count)")
        return events.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //print("number returned in tableView method \(numberOfMonthToDisplay)")
        return 1//numberOfMonthToDisplay
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        tableView.estimatedRowHeight = Reference.estimatedRowHeight
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(Reference.tableViewCell){
            if let description = cell.contentView.viewWithTag(tagTblView.description.rawValue) as? UILabel {
                currentDescription = events[indexPath.row].description
                description.text = currentDescription
            }
            if let date = cell.contentView.viewWithTag(tagTblView.date.rawValue) as? UILabel {
                currentDate = events[indexPath.row].date
                date.text = "\(events[indexPath.row].jourLettreToDisplay) \(events[indexPath.row].jourChiffreToDisplay) à \(events[indexPath.row].heureToDisplay)"
            }
            return cell
        } else {
            //TODO: Throw error
           return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(Reference.detailSegueIdentifier, sender: nil)
    }
    
    //MARK: prepareSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Reference.detailSegueIdentifier {
            if let detailVC = segue.destinationViewController as? DetailViewController {
                detailVC.date = currentDate
                detailVC.texteEvent = currentDescription
            }
        }
    }
}

