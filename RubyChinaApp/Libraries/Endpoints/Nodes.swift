//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import NetworkAbstraction

extension RubyChinaV3 {
    struct Nodes {
        static let Path = "nodes"
    }
}

extension RubyChinaV3.Nodes {
    struct Listing: EndpointType {
        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Nodes.Path }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }

        typealias T = [Node]

        func buildEntity(json: JSON) -> T? {
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
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }

        typealias T = Node

        func buildEntity(json: JSON) -> T? {
            return T(byJSON: json["node"])
        }
    }
}
