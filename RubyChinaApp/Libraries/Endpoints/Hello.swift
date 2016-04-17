//
// Created by 姜军 on 12/16/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import MoyaX

extension RubyChinaV3 {
    struct Hello: EndpointType {
        let baseURL = RubyChinaV3.BaseURL
        let path = "hello"

        typealias DeserializedType = User

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["user"])
        }
    }
}
