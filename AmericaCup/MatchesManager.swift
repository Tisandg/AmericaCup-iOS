//
//  MatchesManager.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/8/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

class MatchesManager {
    
    //Store the books collection
    private lazy var matches:[Match] = self.loadMatches()
    //Store the number of books in the collection
    var matchCount:Int {return matches.count}

    //Get a book from the collection at a specific position
    func getMatch(at index:Int)->Match {
        return matches[index]
    }

    //Return the books collection
    private func loadMatches()->[Match] {
        //for now, loads a dummy hard-coded books collection
        return sampleMatches()
    }

    //Add a book to the collection
    func addMatch(_ match:Match) {
        matches.append(match)
    }

    //Return a dummny collection of books according to Book structure
    private func sampleMatches()->[Match] {
        return [
            Match(teamA:"Colombia",teamB:"Qatar",result:"1–0",date:"05/07/2019"),
            Match(teamA:"Argentina",teamB:"Paraguay",result:"1–1",date:"05/07/2019"),
            Match(teamA:"Brasil",teamB:"Bolivia",result:"3–0",date:"05/07/2019"),
            Match(teamA:"Chile",teamB:"Ecuador",result:"2–1",date:"05/07/2019"),
            Match(teamA:"Paraguay",teamB:"Colombia",result:"0–1",date:"05/07/2019"),
            Match(teamA:"Brasil",teamB:"Peru",result:"5–0", date:"05/07/2019")
        ]
    }
    
}
