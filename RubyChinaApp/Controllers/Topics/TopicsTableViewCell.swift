//
//  TopicsTableViewCell.swift
//  RubyChinaApp
//
//  Created by 姜军 on 12/23/15.
//  Copyright © 2015 RubyChina. All rights reserved.
//

import UIKit

class TopicsTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var repliesCountLabel: UILabel!
    @IBOutlet weak var nodeNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorAvatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            print("select \(self.titleLabel.text)")
        }
    }

}
