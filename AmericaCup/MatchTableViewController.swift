//
//  MatchTableViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/10/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var teamB: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var imageTeamA: UIImageView!
    @IBOutlet weak var imageTeamB: UIImageView!
    
}

class MatchTableViewController: UITableViewController {
    
    let groupaURL = "https://livescore-api.com/api-client/scores/history.json?key=WJBD7vkDnW1zwvNI&secret=nJZX4HNHgOlDE5LAOneVTyzgvBQ17EKv&league=962"
    
    let groupbURL = "https://livescore-api.com/api-client/scores/history.json?key=WJBD7vkDnW1zwvNI&secret=nJZX4HNHgOlDE5LAOneVTyzgvBQ17EKv&league=961"
    
    let groupcURL = "https://livescore-api.com/api-client/scores/history.json?key=WJBD7vkDnW1zwvNI&secret=nJZX4HNHgOlDE5LAOneVTyzgvBQ17EKv&league=960"
    
    var matchesManager:MatchesManager = MatchesManager()
    var teamManager:TeamManager = TeamManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        getMatches(url: groupaURL, idGroup: 1)
        getMatches(url: groupbURL, idGroup: 2)
        getMatches(url: groupcURL, idGroup: 3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
        cell.teamA?.text = match.team_a
        cell.teamB?.text = match.team_b
        cell.result?.text = match.score
        cell.date?.text = match.match_date
        
        cell.imageTeamA?.image = UIImage(named: match.team_a.lowercased()+".png")
        cell.imageTeamB?.image = UIImage(named: match.team_b.lowercased()+".png")
        
        return cell
    }
    
    // Prepare the segue before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*Check that there is a value in the table view’s indexPathForSelectedRow property;
         it will happen when the user selects a row and we will use it for editing purposes*/
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
            /*Unwrap a reference to the destination view controller; as you’ve created the segue directly
             to the book view controller, it will be the destination view controller*/
            let matchViewController = segue.destination
                as? MatchViewController {
            
            //Editing a book
            //TableViewController pass a Book object to BookViewController
            matchViewController.match =
                matchesManager.getMatch(at: selectedIndexPath.row)
            /*Now you have a reference to the BookViewController, and the BooksTableViewController
             can set itself as its delegate.*/
            //matchViewController.delegate = self
            
            /*Because the BookViewController is embedded in a navigation controller, the segue’s destinationViewController
             will be a navigation controller. The destinationViewController property is a UIViewController type,
             so you’ll need to downcast it to a UINavigationController.*/
        } else if let navController = segue.destination
            as? UINavigationController,
            
            /*Now that you have a reference to the navigation controller, you can get a reference to its root view
             controller. You can get a navigation controller’s root view controller with the topViewController property.
             Because this returns a UIViewController object, you’ll need to downcast it to a BookViewController.*/
            let matchViewController = navController.topViewController
                as? MatchViewController {
            
            //Adding a Book
            /*Now you have a reference to the BookViewController, and the BooksTableViewController
             can set itself as its delegate.*/
            //matchViewController.delegate = self
        }
    }
    
    func getMatches(url:String, idGroup:Int){
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    //var matches:[Match] = []
                    let json = JSON(value)
                    let data = json["data"]
                    data["match"].array?.forEach({ (m) in
                        let id = m["id"].intValue
                        let score = m["ft_score"].stringValue
                        let team_a = m["home_name"].stringValue
                        let team_b = m["away_name"].stringValue
                        let team_a_id = m["home_id"].intValue
                        let team_b_id = m["away_id"].intValue
                        let date = m["date"].stringValue
                        let status = m["status"].stringValue
                        let match = Match.init(idMatch: id, idTeamA: team_a_id, idTeamB: team_b_id, teamA: team_a, teamB: team_b, result: score, date: date, status: status,idGroup:idGroup)
                        self.matchesManager.addMatch(match)
                        
                        let teamA = Team.init(id: team_a_id, name: team_a, favorite: 0, team_detail_id: 0, group_id: idGroup)
                        let teamB = Team.init(id: team_b_id, name: team_b, favorite: 0, team_detail_id: 0, group_id: idGroup)
                        self.teamManager.addTeam(teamA)
                        self.teamManager.addTeam(teamB)
                    })
                    //print(json)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }

}
