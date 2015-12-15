//
// Created by 姜军 on 12/15/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Error: CustomDebugStringConvertible, SwiftyJSONMappable {
    let error: String

    init?(byJSON json: JSON) {
        if json.type == .Null { return nil }

        error = json["error"].stringValue
    }
}
