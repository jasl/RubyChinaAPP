//
// Created by 姜军 on 12/7/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftDate

struct Topic: CustomDebugStringConvertible, ModelType {
    let id: String

    let createdAt: NSDate
    let updatedAt: NSDate
    let repliedAt: NSDate?

    let repliesCount: Int

    let nodeName: String
    let nodeId: String

    let lastReplyUserId: String?
    let lastReplyUserLogin: String?

    let isExcellent: Bool
    let isDeleted: Bool

    let title: String

    let user: User
    let abilities: Ability

    let suggestedAt: NSDate?
    let hits: Int?
    let likesCount: Int?
    let body: String?
    let bodyHTML: String?

    var isFollowed = false
    var isLiked = false
    var isFavorited = false

    var identifier: String {
        return "Topic#\(self.id)"
    }

    init?(byJSON json: JSON) {
        if json.type == .Null { return nil }

        self.id = json["id"].stringValue

        self.createdAt = json["created_at"].stringValue.toDate(DateFormat.ISO8601)!
        self.updatedAt = json["updated_at"].stringValue.toDate(DateFormat.ISO8601)!
        self.repliedAt = json["replied_at"].string?.toDate(DateFormat.ISO8601)

        self.repliesCount = json["replies_count"].intValue

        self.nodeName = json["node_name"].stringValue
        self.nodeId = json["node_id"].stringValue

        self.lastReplyUserId = json["last_reply_user_id"].string
        self.lastReplyUserLogin = json["last_reply_user_login"].string

        self.isExcellent = json["excellent"].boolValue
        self.isDeleted = json["deleted"].boolValue

        self.title = json["title"].stringValue

        self.user = User(byJSON: json["user"])!
        self.abilities = Ability(byJSON: json["abilities"])!

        // details
        self.suggestedAt = json["suggested_at"].string?.toDate(DateFormat.ISO8601)
        self.hits = json["hits"].int
        self.likesCount = json["likes_count"].int
        self.body = json["body"].string
        self.bodyHTML = json["body_html"].string
    }
}
