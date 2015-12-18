//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON

struct APIError: CustomDebugStringConvertible, SwiftyJSONMappable, ErrorType {
    let message: String

    init?(byJSON json: JSON) {
        if json.type == .Null { return nil }

        self.message = json["error"].stringValue
    }
}
