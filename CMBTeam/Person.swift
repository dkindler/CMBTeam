//
//  Person.swift
//  CMBTeam
//
//  Created by Dan Kindler on 1/3/17.
//  Copyright © 2017 Dan Kindler. All rights reserved.
//

import UIKit

class Person: NSObject {
    var firstName: String?
    var lastName: String?
    var bio: String?
    var title: String?
    var id: String?
    var avatar: String?
    
    var fullName: String {
        get {
            return "\(firstName ?? "") \(lastName ?? "")"
        }
    }
    
    init(dict: [String: Any]) {
        firstName = dict["firstName"] as? String
        lastName = dict["lastName"] as? String
        bio = dict["bio"] as? String
        title = dict["title"] as? String
        avatar = dict["avatar"] as? String
        id = dict["id"] as? String
    }
}
