//
//  ProfileLayout.swift
//  CMBTeam
//
//  Created by Dan Kindler on 1/4/17.
//  Copyright © 2017 Dan Kindler. All rights reserved.
//

import UIKit
import LayoutKit
import Alamofire

class ProfileLayout: InsetLayout<View> {
    let person: Person
    
    public init(person: Person) {
        self.person = person
        
        let profileImage = SizeLayout<UIImageView>(
            size: CGSize(width: 200, height: 200),
            config: { imageView in
                imageView.layer.cornerRadius = 200/2
                imageView.layer.masksToBounds = true
                
                if let avatarURL = person.avatar, let url = URL(string:avatarURL) {
                    imageView.af_setImage(withURL: url)
                }
            }
        )
        
        let bio = LabelLayout(
            text: person.bio ?? "",
            font: .systemFont(ofSize: 14),
            config: nil
        )
        
        let name = LabelLayout(
            text: person.fullName,
            font:.boldSystemFont(ofSize: 22),
            alignment: .center,
            config: nil
        )
        
        let title = LabelLayout(
            text: person.title?.uppercased() ?? "No Position",
            font: .systemFont(ofSize: 14, weight: UIFontWeightLight),
            alignment: .center,
            config: { label in
                label.textColor = .gray
            }
        )
        
        let header = StackLayout(
            axis: .vertical,
            spacing: 2,
            alignment: Alignment(vertical: .center, horizontal: .center),
            sublayouts: [name, title]
        )
        
        let verticalStack = StackLayout(
            axis: .vertical,
            spacing: 6,
            alignment: Alignment(vertical: .center, horizontal: .center),
            sublayouts: [profileImage, header, bio]
        )
        
        super.init(
            insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
            sublayout: StackLayout(
                axis: .vertical,
                spacing: 12,
                sublayouts: [
                    verticalStack
                ]
            ),
            config: { view in
                view.backgroundColor = UIColor.white
            }
        )
    }
}
