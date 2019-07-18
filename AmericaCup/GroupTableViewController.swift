//
//  GroupTableViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/13/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var team1: UILabel!
    @IBOutlet weak var team2: UILabel!
    @IBOutlet weak var team3: UILabel!
    @IBOutlet weak var team4: UILabel!
    @IBOutlet weak var imageTeam1: UIImageView!
    @IBOutlet weak var imageTeam2: UIImageView!
    @IBOutlet weak var imageTeam3: UIImageView!
    @IBOutlet weak var imageTeam4: UIImageView!
    
}

class GroupTableViewController: UITableViewController {
    
    var groupManager:GroupManager = GroupManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupManager.groupCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        
        let group = groupManager.getGroup(at: indexPath.row)

        cell.nameGroup?.text = group.name
        
        cell.team1?.text = group.teams[0].team_name
        cell.imageTeam1?.image = UIImage(named: group.teams[0].team_name.lowercased()+".png")
        
        cell.team2?.text = group.teams[1].team_name
        cell.imageTeam2?.image = UIImage(named: group.teams[1].team_name.lowercased()+".png")
        
        cell.team3?.text = group.teams[2].team_name
        cell.imageTeam3?.image = UIImage(named: group.teams[2].team_name.lowercased()+".png")
        
        cell.team4?.text = group.teams[3].team_name
        cell.imageTeam4?.image = UIImage(named: group.teams[3].team_name.lowercased()+".png")
        return cell
        
    }
    

}
