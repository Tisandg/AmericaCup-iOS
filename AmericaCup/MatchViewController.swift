//
//  ViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/3/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MatchViewController: UIViewController {
    
    @IBOutlet weak var imageTeamA: UIImageView!
    @IBOutlet weak var imageTeamB: UIImageView!
    @IBOutlet weak var resultTextField: UILabel!
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var nameTeamA: UILabel!
    @IBOutlet weak var nameTeamB: UILabel!
    
    @IBOutlet weak var possesionA: UILabel!
    @IBOutlet weak var precisionA: UILabel!
    @IBOutlet weak var passesA: UILabel!
    @IBOutlet weak var faultsA: UILabel!
    @IBOutlet weak var yellowA: UILabel!
    @IBOutlet weak var redA: UILabel!
    
    @IBOutlet weak var possesionB: UILabel!
    @IBOutlet weak var precisionB: UILabel!
    @IBOutlet weak var passesB: UILabel!
    @IBOutlet weak var faultsB: UILabel!
    @IBOutlet weak var yellowB: UILabel!
    @IBOutlet weak var redB: UILabel!
    
    
    
    let statisticsURL = "https://api.myjson.com/bins/m3nrx"
    
    //Object to hold a Book instance
    var match: Match?
    var teamManger:TeamManager = TeamManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStatistics()
        if let match = match {
            nameTeamA.text = match.team_a
            nameTeamB.text = match.team_b
            resultTextField.text = match.score
            dateTextField.text = match.match_date
            imageTeamA.image = UIImage(named: match.team_a.lowercased()+".png")
            imageTeamB.image = UIImage(named: match.team_b.lowercased()+".png")
            navigationItem.title = "Match Detail"
        }
        
        imageTeamA.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTappedA)))
        imageTeamB.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTappedB)))
    }
    
    @objc private func imageTappedA(_ recognizer: UITapGestureRecognizer) {
        print("image tapped A")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TeamSelected") as! TeamSelectedViewController
        newViewController.team = teamManger.getTeam(id: match!.match_id_team_a)
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc private func imageTappedB(_ recognizer: UITapGestureRecognizer) {
        print("image tapped B")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStatistics(){
        DispatchQueue.main.async {
            Alamofire.request(self.statisticsURL).responseJSON(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    let possessionA = json["possesionA"].stringValue
                    let possessionB = json["possesionB"].stringValue
                    let precisionA = json["precisionA"].stringValue
                    let precisionB = json["precisionB"].stringValue
                    let passesA = json["passesA"].intValue
                    let passesB = json["passesB"].intValue
                    let faultsA = json["faultsA"].intValue
                    let faultsB = json["faultsB"].intValue
                    let yellowA = json["yellowA"].intValue
                    let yellowB = json["yellowB"].intValue
                    let redA = json["redA"].intValue
                    let redB = json["redB"].intValue
                    
                    self.possesionA.text = possessionA
                    self.possesionB.text = possessionB
                    self.precisionA.text = precisionA
                    self.precisionB.text = precisionB
                    self.passesA.text = String(passesA)
                    self.passesB.text = String(passesB)
                    self.faultsA.text = String(faultsA)
                    self.faultsB.text = String(faultsB)
                    self.yellowA.text = String(yellowA)
                    self.yellowB.text = String(yellowB)
                    self.redA.text = String(redA)
                    self.redB.text = String(redB)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }

}

