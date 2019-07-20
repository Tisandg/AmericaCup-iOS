//
//  TeamDetailViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {
    
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var matchesTeam: UITableView!
    
    
    var team: Team?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let team = team {
            nameTeam.text = team.team_name
            imageTeam.image = UIImage(named: team.team_name.lowercased()+".png")
            navigationItem.title = "Favorite Team"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
