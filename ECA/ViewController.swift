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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        let dataTransfert = DataTransfert()
        dataTransfert.delegate = self
        dataTransfert.retrieveData()
    }
    
    func eventHasBeenRetreive(events: [basicEvent]) {
        self.events = events
        eventTableView.reloadData()
    }
    
    //MARK: tableView delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        return events.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(Reference.tableViewCell){
            if let description = cell.contentView.viewWithTag(tagTblView.description.rawValue) as? UILabel {
                description.text = events[indexPath.row].description
            }
            if let date = cell.contentView.viewWithTag(tagTblView.date.rawValue) as? UILabel {
                date.text = events[indexPath.row].jour
                // TODO: pouvoir retourner lundi-mardi-mercredi janvier-février
            }
            if let heure = cell.contentView.viewWithTag(tagTblView.heure.rawValue) as? UILabel {
                heure.text = events[indexPath.row].heure
                // TODO: retourner 20h15
            }
            return cell
        } else {
            //TODO: Throw error
           return UITableViewCell()
        }
    }
}

