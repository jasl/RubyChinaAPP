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
    @IBOutlet weak var nodeNameButton: EmbedsInTableViewCellUIButton!
    @IBOutlet weak var authorNameButton: EmbedsInTableViewCellUIButton!
    @IBOutlet weak var authorAvatarImageButton: EmbedsInTableViewCellUIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.authorAvatarImageButton.kf_cancelImageDownloadTask()
    }
}
