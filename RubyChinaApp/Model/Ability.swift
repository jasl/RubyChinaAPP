//
// Created by 姜军 on 7/10/15.
// Copyright (c) 2015 KnewOne. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Ability: CustomDebugStringConvertible, SwiftyJSONMappable {
    let canUpdate: Bool
    let canDestroy: Bool

    init?(byJSON json: JSON) {
        if json.type == .Null { return nil }

        canUpdate = json["update"].boolValue
        canDestroy = json["destroy"].boolValue
    }

    //TODO: extract this to a protocol after swift 2.0 released
    var debugDescription: String {
        return debugDescriptionFor(self)
    }
}
