//
//  MatchesTeamTableViewCell.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/21/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import UIKit

class MatchesTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var imageA: UIImageView!
    @IBOutlet weak var imageB: UIImageView!
    @IBOutlet weak var nameA: UILabel!
    @IBOutlet weak var nameB: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
