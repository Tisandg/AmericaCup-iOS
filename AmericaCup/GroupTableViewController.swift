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

        cell.nameGroup?.text = group.nameGroup
        
        cell.team1?.text = group.teams[0].nombre
        cell.imageTeam1?.image = UIImage(named: group.teams[0].nombre.lowercased()+".png")
        
        cell.team2?.text = group.teams[1].nombre
        cell.imageTeam2?.image = UIImage(named: group.teams[1].nombre.lowercased()+".png")
        
        cell.team3?.text = group.teams[2].nombre
        cell.imageTeam3?.image = UIImage(named: group.teams[2].nombre.lowercased()+".png")
        
        cell.team4?.text = group.teams[3].nombre
        cell.imageTeam4?.image = UIImage(named: group.teams[3].nombre.lowercased()+".png")
        return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
