//
// Created by 姜军 on 12/14/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import NetworkAbstraction

extension RubyChinaV3 {
    struct Topics {
        static let Path = "topics"
    }
}

extension RubyChinaV3.Topics {
    struct Listing: TargetType {
        enum TypeFieldValue: String {
            case LastActived = "last_actived"
            case Recent = "recent"
            case NoReply = "no_reply"
            case Popular = "popular"
            case Excellent = "excellent"
        }

        var type: TypeFieldValue?
        var nodeId: String?
        var offset: Int?
        var limit: Int?

        init(type: TypeFieldValue? = nil, nodeId: String? = nil, offset: Int? = nil, limit: Int? = nil) {
            self.type = type
            self.nodeId = nodeId
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return Path }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

            if type != nil {
                parameters["type"] = type!.rawValue
            }
            if nodeId != nil {
                parameters["nodeId"] = nodeId!
            }
            if offset != nil {
                parameters["offset"] = offset!
            }
            if limit != nil {
                parameters["limit"] = limit!
            }

            return parameters
        }
    }

    struct Show: TargetType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(Path)/\(id)" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? { return nil }
    }
}
