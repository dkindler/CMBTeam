//
//  TeamMemberCollectionViewCell.swift
//  CMBTeam
//
//  Created by Dan Kindler on 1/3/17.
//  Copyright © 2017 Dan Kindler. All rights reserved.
//

import UIKit
import LayoutKit
import AlamofireImage

class TeamMemberLayout: InsetLayout<View> {
    public init(person: Person) {
        let imageLayout = SizeLayout<UIImageView>(
            width: 120,
            height: 120,
            alignment: .center,
            config: { imageView in
                imageView.layer.cornerRadius = 60
                imageView.layer.masksToBounds = true
                
                imageView.layer.borderColor = UIColor.colorWithRGB(rgbValue: 0x0F7DE5).cgColor
                imageView.layer.borderWidth = 1.0
                
                imageView.image = nil
                if let avatar = person.avatar, let url = URL(string: avatar) {
                    imageView.af_setImage(withURL: url)
                }
            }
        )
        
        let nameLayout = LabelLayout(
            text: person.fullName,
            font: .boldSystemFont(ofSize: 16),
            alignment: .center
        )
        
        let titleLayout = LabelLayout(
            text: person.title?.uppercased() ?? "",
            font: .systemFont(ofSize: 12, weight: UIFontWeightLight),
            numberOfLines: 1,
            alignment: .center,
            config: { label in
                label.textColor = .gray
            }
        )
        
        super.init(
            insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12),
            sublayout: StackLayout(
                axis: .vertical,
                spacing: 4,
                alignment: .topFill,
                viewReuseId: "teammemberlayout",
                sublayouts: [imageLayout, nameLayout, titleLayout]
            ),
            config: nil
        )
    }
}
