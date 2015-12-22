//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON

struct APIError: CustomDebugStringConvertible, ErrorType {
    let message: String
    let type: ErrorCodeType

    init(statusCode: Int, message: String) {
        self.type = ErrorCodeType(byStatusCode: statusCode)
        self.message = message
    }
}

extension APIError {
    enum ErrorCodeType: Int {
        case BadRequest = 400
        case UnAuthorized = 401
        case Forbidden = 403
        case NotFound = 404
        case Unknown = 999

        init(byStatusCode statusCode: Int) {
            if let knownError = self.dynamicType.init(rawValue: statusCode) {
                self = knownError
            } else {
                self = .Unknown
            }
        }
    }
}
