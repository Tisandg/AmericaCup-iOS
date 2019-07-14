//
//  MatchTableViewController.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/10/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var teamB: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var imageTeamA: UIImageView!
    @IBOutlet weak var imageTeamB: UIImageView!
    
}

class MatchTableViewController: UITableViewController {
    
    var matchesManager:MatchesManager = MatchesManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.teamA?.text = match.nameTeamA
        cell.teamB?.text = match.nameTeamB
        cell.result?.text = match.result
        cell.date?.text = match.date
        
        cell.imageTeamA?.image = UIImage(named: match.nameTeamA.lowercased()+".png")
        cell.imageTeamB?.image = UIImage(named: match.nameTeamB.lowercased()+".png")
        
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
