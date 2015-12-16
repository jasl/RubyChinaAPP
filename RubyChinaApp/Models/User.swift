//
// Created by 姜军 on 12/7/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftDate

struct User: CustomDebugStringConvertible, SwiftyJSONMappable {
    let id: String

    let login: String
    let name: String?
    let avatarUrl: NSURL

    let location: String?
    let company: String?
    let twitter: String?
    let website: NSURL?
    let bio: String?
    let tagline: String?
    let github: String?
    let email: String?

    let topicsCount: Int?
    let repliesCount: Int?
    let followingCount: Int?
    let followersCount: Int?
    let favoritesCount: Int?

    let level: LevelValue?
    let levelName: String?

    let createdAt: NSDate?

    init?(byJSON json: JSON) {
        if json.type == .Null { return nil }

        self.id = json["id"].stringValue

        self.login = json["login"].stringValue
        self.name = json["name"].string
        self.avatarUrl = NSURL(string: json["avatar_url"].stringValue)!

        // details
        self.location = json["location"].string
        self.company = json["company"].string
        self.twitter = json["twitter"].string
        if let website = json["website"].string {
            self.website = NSURL(string: website)
        } else {
            self.website = nil
        }
        self.bio = json["bio"].string
        self.tagline = json["tagline"].string
        self.github = json["github"].string
        self.email = json["email"].string

        self.topicsCount = json["topics_count"].int
        self.repliesCount = json["replies_count"].int
        self.followingCount = json["following_count"].int
        self.followersCount = json["followers_count"].int
        self.favoritesCount = json["favorites_count"].int

        self.level = LevelValue(byJSON: json["level"])
        self.levelName = json["level_name"].string

        self.createdAt = json["created_at"].string?.toDate(DateFormat.ISO8601)
    }
}

extension User {
    enum LevelValue: String, CustomDebugStringConvertible, SwiftyJSONMappable {
        case Admin = "admin"
        case VIP = "vip"
        case HR = "hr"
        case Blocked = "blocked"
        case Newbie = "newbie"
        case Normal = "normal"

        init?(byJSON json: JSON) {
            if json.type == .Null { return nil }

            if let value = self.dynamicType.init(rawValue: json.stringValue) {
                self = value
            } else {
                self = .Normal
            }
        }
    }
}
