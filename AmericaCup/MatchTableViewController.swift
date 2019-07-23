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
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesManager.matchCount
    }
    
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchTableViewCell
        
        let match = matchesManager.getMatch(at: indexPath.row)
        
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
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow,

            let matchViewController = segue.destination
                as? MatchViewController {
            
            matchViewController.match =
                matchesManager.getMatch(at: selectedIndexPath.row)

        } else if let navController = segue.destination
            as? UINavigationController,
            

            let matchViewController = navController.topViewController
                as? MatchViewController {
            
        }
    }
    
    func getMatches(url:String, idGroup:Int){
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
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
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }

}
