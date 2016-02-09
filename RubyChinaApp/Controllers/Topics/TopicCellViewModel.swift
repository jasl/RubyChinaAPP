//
// Created by 姜军 on 1/7/16.
// Copyright (c) 2016 RubyChina. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

struct TopicCellViewModel: ViewModelType {
    let id: String
    let title: String
    let repliesCount: Int
    let nodeName: String
    let authorName: String
    let authorAvatarURL: NSURL

    init(byEntity entity: Topic) {
        self.id = entity.id
        self.title = entity.title
        self.repliesCount = entity.repliesCount
        self.nodeName = entity.nodeName
        self.authorName = entity.user.login
        self.authorAvatarURL = entity.user.avatarUrl
    }

    func applyTo(cell: TopicsTableViewCell) {
        cell.titleLabel.text = self.title
        cell.repliesCountLabel.text = String(self.repliesCount)

        cell.authorNameButton.setTitle(self.authorName, forState: .Normal)
        cell.authorNameButton.titleLabel!.adjustsFontSizeToFitWidth = true

        cell.nodeNameButton.setTitle(self.nodeName, forState: .Normal)
        cell.nodeNameButton.titleLabel!.adjustsFontSizeToFitWidth = true

        cell.authorAvatarImageButton.kf_setImageWithURL(self.authorAvatarURL,
                                                        forState: .Normal,
                                                        placeholderImage: nil,
                                                        optionsInfo: [.Transition(ImageTransition.Fade(0.1))])
    }

    func applyTo(viewController: TopicDetailViewController) {
        viewController.topicId = self.id
        viewController.title = self.title
    }
}

func toTopicCellViewModel(topics: [Topic]) -> [TopicCellViewModel] {
    var viewModels = [TopicCellViewModel]()
    for topic in topics {
        viewModels.append(TopicCellViewModel(byEntity: topic))
    }

    return viewModels
}
