//
//  TeamSelectedViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/21/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class TeamSelectedViewController: UIViewController {

    var team:Team?
    var teamManager:TeamManager = TeamManager()
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var favorites: UIBarButtonItem!
    
    @IBAction func volverMatch(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addFavoritos(_ sender: UIBarButtonItem) {
        var respuesta:Int = teamManager.changeToFavorite(id: team!.team_id)
        print("respuesta ",respuesta)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTeam.image = UIImage(named: team!.team_name.lowercased()+".png")
        nameTeam.text = team!.team_name
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
