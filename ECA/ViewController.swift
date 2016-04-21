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
    var currentDescription: String?

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
                currentDescription = events[indexPath.row].description
                description.text = currentDescription
            }
            if let date = cell.contentView.viewWithTag(tagTblView.date.rawValue) as? UILabel {
                currentDate = events[indexPath.row].date
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

