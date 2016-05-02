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
    
    // pour le transfert de données
    var events = [basicEvent]()
    let dataTransfert = DataTransfert()
    // pour le calcul de l'affichage de la tableView
    var numberOfMonthToDisplay = Int()
    var numberOfEventInEachSection = [Int]()
    // pour l'affichage de la tableView
    var currentDate: NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        dataTransfert.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        dataTransfert.retrieveData()
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
    
    private func dateToText(index:NSIndexPath) -> String {
        return "\(events[index.row].jourLettreToDisplay) \(events[index.row].jourChiffreToDisplay) à \(events[index.row].heureToDisplay)"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(Reference.tableViewCell){
            if let description = cell.contentView.viewWithTag(tagTblView.description.rawValue) as? UILabel {
                description.text = events[indexPath.row].description
                //print(description.frame.height)
            }
            if let date = cell.contentView.viewWithTag(tagTblView.date.rawValue) as? UILabel {
                currentDate = events[indexPath.row].date
                date.text = dateToText(indexPath)
            }
            
            return cell
        } else {
            //TODO: Throw error
           return UITableViewCell()
        }
    }
    // le forRow est initialisé à -1 afin que aucun row ne corresponde à l'initialisation
    var selectedRowIndex = NSIndexPath(forRow: -1, inSection: 0)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRowIndex = indexPath
        tableView.beginUpdates()
        tableView.endUpdates()
        
        let textToShare = "J'ai trouvé un événement super!"
        
        let descriptionToShare = events[indexPath.row].description
        print(descriptionToShare)
        let dateToShare = dateToText(indexPath) + "."
        print(dateToShare)
        
        let objectsToShare = [textToShare, dateToShare, descriptionToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//        
//        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
//        
//        self.presentViewController(activityVC, animated: true, completion: nil)
//        
//        let activityViewController = UIActivityViewController(activityItems: [textToShare, testUrl!], applicationActivities: nil)
        self.presentViewController(activityVC, animated: true) {
//            // ...
        }
//        shareTapped()
        
    }
    
    func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Hello"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        presentViewController(vc, animated: true, completion: nil)
    }
    
}

