//
// Created by 姜军 on 7/13/15.
// Copyright (c) 2015 KnewOne. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol SwiftyJSONMappable {
    init?(byJSON json: JSON)
}

extension Array where Element: SwiftyJSONMappable {
    init(byJSON json: JSON) {
        self.init()

        if json.type == .Null { return }

        for item in json.arrayValue {
            if let object = Element.init(byJSON: item) {
                self.append(object)
            }
        }
    }
}
