//
// Created by 姜军 on 12/14/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import NetworkAbstraction

extension Response {
    func mapSwiftyJSON() -> JSON {
        return JSON(data: data)
    }
}
