//
// Created by 姜军 on 12/16/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import MoyaX

extension RubyChinaV3 {
    struct Hello: EndpointType {
        static let Path = "hello"

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Hello.Path }

        typealias T = User

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["user"])
        }
    }
}
