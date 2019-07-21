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
    
    @IBOutlet weak var wonTeam1: UILabel!
    @IBOutlet weak var drawnTeam1: UILabel!
    @IBOutlet weak var lostTeam1: UILabel!
    @IBOutlet weak var pointsTeam1: UILabel!
  
    
    @IBOutlet weak var wonTeam2: UILabel!
    @IBOutlet weak var drawnTeam2: UILabel!
    @IBOutlet weak var lostTeam2: UILabel!
    @IBOutlet weak var pointsTeam2: UILabel!
    
    @IBOutlet weak var wonTeam3: UILabel!
    @IBOutlet weak var drawnTeam3: UILabel!
    @IBOutlet weak var lostTeam3: UILabel!
    @IBOutlet weak var pointsTeam3: UILabel!
    
    @IBOutlet weak var wonTeam4: UILabel!
    @IBOutlet weak var drawnTeam4: UILabel!
    @IBOutlet weak var lostTeam4: UILabel!
    @IBOutlet weak var pointsTeam4: UILabel!
    
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
        
        cell.team1?.text = group.teams[0].nameTeam
        cell.imageTeam1?.image = UIImage(named: group.teams[0].nameTeam.lowercased()+".png")
        cell.wonTeam1?.text = String(group.teams[0].won)
        cell.drawnTeam1?.text = String(group.teams[0].drawn)
        cell.lostTeam1?.text = String(group.teams[0].lost)
        cell.pointsTeam1?.text = String(group.teams[0].points)
        
        cell.team2?.text = group.teams[1].nameTeam
        cell.imageTeam2?.image = UIImage(named: group.teams[1].nameTeam.lowercased()+".png")
        cell.wonTeam2?.text = String(group.teams[1].won)
        cell.drawnTeam2?.text = String(group.teams[1].drawn)
        cell.lostTeam2?.text = String(group.teams[1].lost)
        cell.pointsTeam2?.text = String(group.teams[1].points)
        
        cell.team3?.text = group.teams[2].nameTeam
        cell.imageTeam3?.image = UIImage(named: group.teams[2].nameTeam.lowercased()+".png")
        cell.wonTeam3?.text = String(group.teams[2].won)
        cell.drawnTeam3?.text = String(group.teams[2].drawn)
        cell.lostTeam3?.text = String(group.teams[2].lost)
        cell.pointsTeam3?.text = String(group.teams[2].points)
        
        cell.team4?.text = group.teams[3].nameTeam
        cell.imageTeam4?.image = UIImage(named: group.teams[3].nameTeam.lowercased()+".png")
        cell.wonTeam4?.text = String(group.teams[3].won)
        cell.drawnTeam4?.text = String(group.teams[3].drawn)
        cell.lostTeam4?.text = String(group.teams[3].lost)
        cell.pointsTeam4?.text = String(group.teams[3].points)
        
        return cell
        
    }
    

}
