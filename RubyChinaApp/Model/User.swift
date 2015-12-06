//
// Created by 姜军 on 12/7/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User: CustomDebugStringConvertible, SwiftyJSONMappable {
    let id: String

    let login: String
    let name: String?
    let avatar_url: NSURL

    //TODO: Not finished

    init?(byJSON json: JSON) {
        id = json["id"].stringValue
        login = json["login"].stringValue
        name = json["name"].string
        avatar_url = NSURL(string: json["avatar_url"].stringValue)!
    }

    //TODO: extract this to a protocol after swift 2.0 released
    var debugDescription: String {
        return debugDescriptionFor(self)
    }
}
