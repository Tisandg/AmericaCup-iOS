//
//  ViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/3/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {
    
    @IBOutlet weak var imageTeamA: UIImageView!
    @IBOutlet weak var imageTeamB: UIImageView!
    @IBOutlet weak var resultTextField: UILabel!
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var nameTeamA: UILabel!
    @IBOutlet weak var nameTeamB: UILabel!
    
    //Object to hold a Book instance
    var match: Match?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //If match object is not null (e.g. an update operation), fill out the form fields with Book data
        if let match = match {
            nameTeamA.text = match.nameTeamA
            nameTeamB.text = match.nameTeamB
            resultTextField.text = match.result
            dateTextField.text = match.date
            navigationItem.title = "Match Detail"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

