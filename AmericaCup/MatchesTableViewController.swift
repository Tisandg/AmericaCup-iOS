//
//  MatchesTableViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/8/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var teamB: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var imageTeamA: UIImageView!
    @IBOutlet weak var imageTeamB: UIImageView!
    
}

class MatchesTableViewController: UITableViewController {
    
    var matchesManager:MatchesManager = MatchesManager()
    
    //Returns the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //Returns the number of rows in the table section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows according to matches collection size, because we have a match per row
        return matchesManager.matchCount
    }
    
    //Sets the cell look and feel and data in the table row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        
        /*It first checks for any cells with the requested reuse identifier in the cache, and if none are found,
         it creates a new cell. When a cell is scrolled offscreen, rather than removing the cell from memory,
         it's sent to the cache to be reused*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchTableViewCell
        
        /*IndexPath parameter contains the number of the section and the row of the cell it’s interested in. It then
         gets a table view cell for this index path, based on the reuse identifier you defined earlier in Interface Builder.
         The index path is generally useful here to know what data to inject into the cell*/
        let match = matchesManager.getMatch(at: indexPath.row)
        
        //Set the text, label an image for each according to the format design we chose for the cell
        cell.teamA?.text = match.nameTeamA
        cell.teamB?.text = match.nameTeamB
        cell.result?.text = match.result
        cell.date?.text = match.date

        cell.imageTeamA?.image = match.coverA
        cell.imageTeamB?.image = match.coverB
        
        return cell
        
    }
    
}
