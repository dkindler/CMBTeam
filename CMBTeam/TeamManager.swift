//
//  TeamManager.swift
//  CMBTeam
//
//  Created by Dan Kindler on 1/3/17.
//  Copyright © 2017 Dan Kindler. All rights reserved.
//

import UIKit
import SwiftyJSON

class TeamManager: NSObject {
    static let shared = TeamManager()
    
    var teamMembers: [Person] {
        get {
            return fetchDummyData().sorted { $0.fullName < $1.fullName }
        }
    }
    
    //MARK: Helpers
    private func fetchDummyData() -> [Person] {
        if let path = Bundle.main.path(forResource: "team", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let jsonData = try Data(contentsOf: url)
                if let json = JSON(data: jsonData).array {
                    var teamMembers = [Person]()
                    for person in json {
                        if let person = person.dictionaryObject {
                            teamMembers.append(Person(dict: person))
                        }
                    }
                    
                    return teamMembers
                }
            } catch _ {
                return [Person]()
            }
        }
        
        return [Person]()
    }
}
