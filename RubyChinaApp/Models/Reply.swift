//
// Created by 姜军 on 12/7/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftDate

struct Reply: CustomDebugStringConvertible, ModelType {
    let id: String
    let topicId: String

    let createdAt: NSDate
    let updatedAt: NSDate

    let likesCount: Int

    let isDeleted: Bool

    let bodyHTML: String

    let user: User
    let abilities: Ability

    let body: String?

    var isLiked = false

    var identifier: String {
        return "Reply#\(self.id)"
    }

    init?(byJSON json: JSON) {
        if json.type == .Null { return nil }

        self.id = json["id"].stringValue
        self.topicId = json["topic_id"].stringValue

        self.createdAt = json["created_at"].stringValue.toDate(DateFormat.ISO8601Format(.Extended))!
        self.updatedAt = json["updated_at"].stringValue.toDate(DateFormat.ISO8601Format(.Extended))!

        self.likesCount = json["likes_count"].intValue

        self.isDeleted = json["deleted"].boolValue

        self.bodyHTML = json["body_html"].stringValue

        self.user = User(byJSON: json["user"])!
        self.abilities = Ability(byJSON: json["abilities"])!

        // details
        self.body = json["body"].string
    }
}
