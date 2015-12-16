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

            if let type = self.type {
                parameters["type"] = type.rawValue
            }
            if let nodeId = self.nodeId {
                parameters["nodeId"] = nodeId
            }
            if let offset = self.offset {
                parameters["offset"] = offset
            }
            if let limit = self.limit {
                parameters["limit"] = limit
            }

            return parameters
        }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Get: TargetType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Create: TargetType {
        var nodeId: String
        var title: String
        var body: String

        init(title: String, body: String, nodeId: String) {
            self.title = title
            self.body = body
            self.nodeId = nodeId
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Topics.Path }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

            parameters["title"] = self.title
            parameters["body"] = self.body
            parameters["node_id"] = self.nodeId

            return parameters
        }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Update: TargetType {
        var id: String
        var nodeId: String
        var title: String
        var body: String

        init(id: String, title: String, body: String, nodeId: String) {
            self.id = id
            self.title = title
            self.body = body
            self.nodeId = nodeId
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)" }
        var method: NetworkAbstraction.Method { return .PUT }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

            parameters["title"] = self.title
            parameters["body"] = self.body
            parameters["node_id"] = self.nodeId

            return parameters
        }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Destroy: TargetType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)" }
        var method: NetworkAbstraction.Method { return .DELETE }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Like: TargetType {
        static let Path = "likes"
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Topics.Like.Path }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

            parameters["obj_type"] = "topic"
            parameters["obj_id"] = self.id

            return parameters
        }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct UndoLike: TargetType {
        static let Path = "likes"
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Topics.UndoLike.Path }
        var method: NetworkAbstraction.Method { return .DELETE }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

            parameters["obj_type"] = "topic"
            parameters["obj_id"] = self.id

            return parameters
        }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Favorite: TargetType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)/favorite" }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct UndoFavorite: TargetType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)/unfavorite" }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Follow: TargetType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)/follow" }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct UndoFollow: TargetType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)/unfollow" }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }
}
