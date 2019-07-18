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
        // Do any additional setup after loadißng the view, typically from a nib.
        //If match object is not null (e.g. an update operation), fill out the form fields with Book data
        if let match = match {
            nameTeamA.text = match.team_a
            nameTeamB.text = match.team_b
            resultTextField.text = match.score
            dateTextField.text = match.match_date
            imageTeamA.image = UIImage(named: match.team_a.lowercased()+".png")
            imageTeamB.image = UIImage(named: match.team_b.lowercased()+".png")
            navigationItem.title = "Match Detail"
        }
        
        let tapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        imageTeamA.addGestureRecognizer(tapGestureRecognizer)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationController = mainStoryBoard.instantiateViewController(withIdentifier: "TeamDetailController") as? TeamDetailViewController else{
            print("Couldn t find the view controller")
            return
        }
        present(destinationController, animated: true, completion: nil)
        //performSegue(withIdentifier: "TeamDetailViewController", sender: nil)
    }

}

