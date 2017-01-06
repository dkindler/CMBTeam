//
//  ProfileViewController.swift
//  CMBTeam
//
//  Created by Dan Kindler on 1/4/17.
//  Copyright © 2017 Dan Kindler. All rights reserved.
//

import UIKit
import LayoutKit

class ProfileViewController: UIViewController {
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        edgesForExtendedLayout = UIRectEdge()
        
        let width = view.bounds.width
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            if let person = self.person {
                let nickProfile = ProfileLayout(person: person)
                
                let arrangement = nickProfile.arrangement(width: width)
                DispatchQueue.main.async(execute: {
                    arrangement.makeViews(in: self.view)
                })
            }
        }
    }
}
