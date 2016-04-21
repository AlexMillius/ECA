//
//  DetailViewController.swift
//  ECA
//
//  Created by Mohamed Lee on 21.04.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var addCalendarBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var remindMeBtn: UIButton!
    
    var date: NSDate?
    var jour: String?
    var texteEvent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLbl.text = texteEvent
        
    }
    
    
    @IBAction func retourTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    

}
