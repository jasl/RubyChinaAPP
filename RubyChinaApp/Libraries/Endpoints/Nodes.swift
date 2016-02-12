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
        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Nodes.Path }

        typealias T = [Node]

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["nodes"])
        }
    }

    struct Get: EndpointType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Nodes.Path)/\(self.id)" }

        typealias T = Node

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["node"])
        }
    }
}
