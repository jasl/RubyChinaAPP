//
// Created by 姜军 on 7/13/15.
// Copyright (c) 2015 KnewOne. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol SwiftyJSONMappable {
    init?(byJSON json: JSON)
}
