//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import MoyaX

extension RubyChinaV3 {
    struct Nodes {
        static let Path = "nodes"
    }
}

extension RubyChinaV3.Nodes {
    struct Listing: EndpointType {
        let baseURL = RubyChinaV3.BaseURL
        let path = RubyChinaV3.Nodes.Path

        typealias DeserializedType = [Node]

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["nodes"])
        }
    }

    struct Get: EndpointType {
        let id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Nodes.Path)/\(self.id)" }

        typealias DeserializedType = Node

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["node"])
        }
    }
}
