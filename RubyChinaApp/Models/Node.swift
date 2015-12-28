//
// Created by 姜军 on 12/7/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftDate

struct Node: CustomDebugStringConvertible, SwiftyJSONMappable {
    let id: String

    let topicsCount: Int

    let sectionId: String
    let sectionName: String

    let sort: Int

    let name: String
    let summary: String
    let updatedAt: NSDate

    init?(byJSON json: JSON) {
        if json.type == .Null { return nil }

        self.id = json["id"].stringValue

        self.topicsCount = json["topics_count"].intValue

        self.sectionId = json["section_id"].stringValue
        self.sectionName = json["section_name"].stringValue

        self.sort = json["sort"].intValue

        self.name = json["name"].stringValue
        self.summary = json["summary"].stringValue
        self.updatedAt = json["updated_at"].stringValue.toDate(DateFormat.ISO8601)!
    }
}

extension Node: Hashable, Equatable {
    public var hashValue: Int {
        return "Node#\(self.id)".hashValue
    }
}

func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.id == rhs.id
}
