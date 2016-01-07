//
// Created by 姜军 on 1/7/16.
// Copyright (c) 2016 RubyChina. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

struct TopicCellViewModel: ViewModelType {
    let title: String
    let repliesCount: Int
    let nodeName: String
    let authorName: String
    let authorAvatarURL: NSURL

    init(byEntity entity: Topic) {
        self.title = entity.title
        self.repliesCount = entity.repliesCount
        self.nodeName = entity.nodeName
        self.authorName = entity.user.login
        self.authorAvatarURL = entity.user.avatarUrl
    }

    func applyToCell(cell: TopicsTableViewCell) {
        cell.titleLabel.text = self.title
        cell.authorNameLabel.text = self.authorName
        cell.nodeNameLabel.text = self.nodeName
        cell.repliesCountLabel.text = String(self.repliesCount)
        cell.authorAvatarImageView.kf_setImageWithURL(self.authorAvatarURL,
                placeholderImage: nil,
                optionsInfo: [.Transition(ImageTransition.Fade(0.1))])
    }
}

func toTopicCellViewModel(topics: [Topic]) -> [TopicCellViewModel] {
    var viewModels = [TopicCellViewModel]()
    for topic in topics {
        viewModels.append(TopicCellViewModel(byEntity: topic))
    }

    return viewModels
}
