//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import NetworkAbstraction

enum APIResult<T> {
    case Ok
    case Success(T)
    case Failure(APIError)
    case NetworkError(NetworkAbstraction.Error)
}
