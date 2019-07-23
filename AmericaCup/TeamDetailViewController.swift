//
//  TeamDetailViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/21/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit


class TeamDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var nameTeam: UILabel!
    
    var team:Team?
    var matches:[Match] = []
    var matchManager: MatchesManager = MatchesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matches = matchManager.getMatchesTeam(idTeam: team!.team_id)!
        nameTeam.text = team!.team_name
        imageTeam.image = UIImage(named: team!.team_name.lowercased()+".png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "matchTeamCell") as! MatchesTeamTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchTeamCell", for: indexPath) as! MatchesTeamTableViewCell
        let match = matches[indexPath.row]
        cell.nameA!.text = match.team_a
        cell.nameB!.text = match.team_b
        cell.result!.text = match.score
        cell.date!.text = match.match_date
        cell.imageA!.image = UIImage(named: match.team_a.lowercased()+".png")
        cell.imageB!.image = UIImage(named: match.team_b.lowercased()+".png")
        return cell
    }
    
    
    
}
