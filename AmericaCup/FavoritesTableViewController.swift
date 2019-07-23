//
//  FavoritesTableViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var teamManager:TeamManager = TeamManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Favorites charged")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.teamManager = TeamManager()
        self.tableView.reloadData()
        super.viewDidAppear(animated)
        print("Aparecio")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teamManager.favoritesCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamFavoriteCell", for: indexPath)
        let team = teamManager.getFavorite(at: indexPath.row)
        
        //Set the text, label an image for each according to the format design we chose for the cell
        cell.textLabel?.text = team.team_name
        cell.imageView?.image = UIImage(named: team.team_name.lowercased()+".png")

        return cell
    }
    
    // Prepare the segue before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow,

            let teamDeatilController = segue.destination
                as? TeamDetailViewController {
            
            teamDeatilController.team =
                teamManager.getFavorite(at: selectedIndexPath.row)

        } else if let navController = segue.destination
            as? UINavigationController,
            
            let teamDeatilController = navController.topViewController
                as? TeamDetailViewController {
        }
    }

}

/*extension FavoritesTableViewController:TeamViewControllerDelegate {

    func changeToFavorite(_ team: Team) -> Int{
        let result = teamManager.changeToFavorite(id: team.team_id)
        print("Result favorites",result)
        tableView.reloadData()
        return result
    }
}*/

