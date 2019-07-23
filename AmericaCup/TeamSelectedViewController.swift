//
//  TeamSelectedViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/21/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class TeamSelectedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var team:Team?
    var matches:[Match] = []
    var teamManager:TeamManager = TeamManager()
    var matchManager:MatchesManager = MatchesManager()
    //var delegate: TeamViewControllerDelegate?
    
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var favorites: UIBarButtonItem!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    
    @IBAction func volverMatch(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addFavoritos(_ sender: UIBarButtonItem) {
        var respuesta:Int = teamManager.changeToFavorite(id: team!.team_id)
        print("respuesta ",respuesta)
    }
    
    @IBAction func volverAtras(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func teamToFavorite(_ sender: UIButton) {
        //let respuesta = delegate?.changeToFavorite(team!)
        let respuesta:Int = teamManager.changeToFavorite(id: team!.team_id)
        print("respuesta TeamSelected",respuesta)
        if(respuesta == 1){
            self.buttonFavorite.setTitle("Quitar", for: UIControlState.normal)
        }else{
            self.buttonFavorite.setTitle("Favorites", for: UIControlState.normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matches = matchManager.getMatchesTeam(idTeam: team!.team_id)!
        imageTeam.image = UIImage(named: team!.team_name.lowercased()+".png")
        nameTeam.text = team!.team_name
        if(team!.favorite == 1){
            self.buttonFavorite.setTitle("Quitar", for: UIControlState.normal)
        }else{
            self.buttonFavorite.setTitle("Favorites", for: UIControlState.normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

/*protocol TeamViewControllerDelegate {
    func changeToFavorite(_ team: Team) -> Int
}*/
