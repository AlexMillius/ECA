//
//  ViewController.swift
//  ECA
//
//  Created by Mohamed Lee on 20.04.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataTransfert = DataTransfert()
        dataTransfert.retrieveDataOnce()
        
//        let jeudi21 = ["date":"21.04.2016","heure":"19h30","description":"Soirée Bhajans et chants du coeur, avec Luc Raimondi","lieu":"espace culturel","intervenant":"Luc Raimondi"]
//        let samedi23 = ["date":"23.04.2016","heure":"20h00","description":"Spectacle Mémoires partagées: dans le prolongement de la Semaine d'actions contre le Racisme, des femmes de tout horizon partagent leurs histoires en paroles et en chants, accompagnées d'Emilie Vuissoz et de Pauline Lugon.","lieu":"espace culturel","intervenant":""]
//        
//        let eventsRef = Reference.firebaseRoot.childByAppendingPath(Reference.ecaEvent)
//        
//        let events = ["jeudi21": jeudi21, "samedi23": samedi23]
//        eventsRef.setValue(events)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

