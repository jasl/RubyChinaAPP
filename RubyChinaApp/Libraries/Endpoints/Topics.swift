//
// Created by 姜军 on 12/14/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import MoyaX

extension RubyChinaV3 {
    struct Topics {
        static let Path = "topics"
    }
}

extension RubyChinaV3.Topics {
    struct Listing: EndpointType, OffsetPaginatable {
        enum TypeFieldValue: String {
            case LastActived = "last_actived"
            case Recent = "recent"
            case NoReply = "no_reply"
            case Popular = "popular"
            case Excellent = "excellent"
        }

        let type: TypeFieldValue?
        let nodeId: String?
        var offset: Int
        var limit: Int

        init(type: TypeFieldValue? = nil, nodeId: String? = nil, offset: Int = 0, limit: Int = 20) {
            self.type = type
            self.nodeId = nodeId
            self.offset = offset
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        let path = RubyChinaV3.Topics.Path
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            if let type = self.type {
                parameters["type"] = type.rawValue
            }
            if let nodeId = self.nodeId {
                parameters["nodeId"] = nodeId
            }

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias DeserializedType = [Topic]

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["topics"])
        }
    }

    struct Get: EndpointType {
        let id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)" }

        typealias DeserializedType = Topic

        func parseResponse(json: JSON) -> DeserializedType? {
            if json["topic"].type == .Null {
                return nil
            }

            var topic = DeserializedType(byJSON: json["topic"])!

            if let isFollowed = json["meta"]["followed"].bool {
                topic.isFollowed = isFollowed
            }
            if let isLiked = json["meta"]["liked"].bool {
                topic.isLiked = isLiked
            }
            if let isFavorited = json["meta"]["favorited"].bool {
                topic.isFavorited = isFavorited
            }

            return topic
        }
    }

    struct Create: EndpointType {
        let nodeId: String
        let title: String
        let body: String

        init(title: String, body: String, nodeId: String) {
            self.title = title
            self.body = body
            self.nodeId = nodeId
        }

        let baseURL = RubyChinaV3.BaseURL
        let path = RubyChinaV3.Topics.Path
        let method = HTTPMethod.POST
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["title"] = self.title
            parameters["body"] = self.body
            parameters["node_id"] = self.nodeId

            return parameters
        }

        typealias DeserializedType = Topic

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["topic"])
        }
    }

    struct Update: EndpointType {
        let id: String
        let nodeId: String
        let title: String
        let body: String

        init(id: String, title: String, body: String, nodeId: String) {
            self.id = id
            self.title = title
            self.body = body
            self.nodeId = nodeId
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)" }
        let method = HTTPMethod.PUT
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["title"] = self.title
            parameters["body"] = self.body
            parameters["node_id"] = self.nodeId

            return parameters
        }

        typealias DeserializedType = Topic

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["topic"])
        }
    }

    struct Destroy: EndpointType {
        var id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)" }
        let method = HTTPMethod.DELETE

        typealias DeserializedType = AnyObject
    }

    struct Like: EndpointType {
        var id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        let path = "likes"
        let method = HTTPMethod.POST
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["obj_type"] = "topic"
            parameters["obj_id"] = self.id

            return parameters
        }

        typealias DeserializedType = AnyObject
    }

    struct UnLike: EndpointType {
        let id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        let path = "likes"
        let method = HTTPMethod.DELETE
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["obj_type"] = "topic"
            parameters["obj_id"] = self.id

            return parameters
        }

        typealias DeserializedType = AnyObject
    }

    struct Favorite: EndpointType {
        var id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)/favorite" }
        let method = HTTPMethod.POST

        typealias DeserializedType = AnyObject
    }

    struct UnFavorite: EndpointType {
        var id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)/unfavorite" }
        var method = HTTPMethod.POST

        typealias DeserializedType = AnyObject
    }

    struct Follow: EndpointType {
        let id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)/follow" }
        let method = HTTPMethod.POST

        typealias DeserializedType = AnyObject
    }

    struct UnFollow: EndpointType {
        var id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.id)/unfollow" }
        let method = HTTPMethod.POST

        typealias DeserializedType = AnyObject
    }
}
