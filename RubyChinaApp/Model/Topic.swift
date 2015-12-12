//
// Created by 姜军 on 12/7/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftDate

struct Topic: CustomDebugStringConvertible, SwiftyJSONMappable {
    let id: String

    let created_at: NSDate
    let updated_at: NSDate
    let replied_at: NSDate?
    let suggested_at: NSDate?

    let replies_count: Int
    let hits: Int
    let likes_count: Int

    let node_name: String
    let node_id: String

    let last_reply_user_id: String?
    let last_reply_user_login: String?

    let is_excellent: Bool
    let is_deleted: Bool

    let title: String
    let body: String?
    let body_html: String?

    let user: User
    let abilities: Ability

    init?(byJSON json: JSON) {
        if json.type == .Null { return nil }

        id = json["id"].stringValue

        created_at = json["created_at"].stringValue.toDate(DateFormat.ISO8601)!
        updated_at = json["updated_at"].stringValue.toDate(DateFormat.ISO8601)!
        replied_at = json["replied_at"].string?.toDate(DateFormat.ISO8601)
        suggested_at = json["suggested_at"].string?.toDate(DateFormat.ISO8601)

        replies_count = json["replies_count"].intValue
        hits = json["hits"].intValue
        likes_count = json["likes_count"].intValue

        node_name = json["node_name"].stringValue
        node_id = json["node_id"].stringValue

        last_reply_user_id = json["last_reply_user_id"].string
        last_reply_user_login = json["last_reply_user_login"].string

        is_excellent = json["excellent"].boolValue
        is_deleted = json["deleted"].boolValue

        title = json["title"].stringValue
        body = json["body"].string
        body_html = json["body_html"].string

        user = User(byJSON: json["user"])!
        abilities = Ability(byJSON: json["abilities"])!
    }
}
