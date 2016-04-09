//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import MoyaX

extension RubyChinaV3 {
    struct Replies {
        static let Path = "replies"
    }
}

extension RubyChinaV3.Replies {
    struct Listing: EndpointType, OffsetPaginatable {
        var topicId: String
        var offset: Int
        var limit: Int

        init(topicId: String, offset: Int = 0, limit: Int = 20) {
            self.topicId = topicId
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.topicId)/\(RubyChinaV3.Replies.Path)" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias T = [Reply]

        func parseResponse(json: JSON) -> T? {
            var topics = T(byJSON: json["replies"])

            if let userLikedReplyIDs = json["meta"]["user_liked_reply_ids"].array?.map({ $0.stringValue }) where !userLikedReplyIDs.isEmpty {
                for (index, topic) in topics.enumerate() {
                    if userLikedReplyIDs.contains(topic.id) {
                        topics[index].isLiked = true
                    }
                }
            }

            return topics
        }
    }

    struct Create: EndpointType {
        var topicId: String
        var body: String

        init(topicId: String, body: String) {
            self.topicId = topicId
            self.body = body
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.topicId)/\(RubyChinaV3.Replies.Path)" }
        var method: HTTPMethod { return .POST }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["body"] = self.body

            return parameters
        }

        typealias T = Reply

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["reply"])
        }
    }

    struct Get: EndpointType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Replies.Path)/\(self.id)" }

        typealias T = Reply

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["reply"])
        }
    }

    struct Destroy: EndpointType {
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Replies.Path)/\(self.id)" }
        var method: HTTPMethod { return .DELETE }

        typealias T = AnyObject
    }

    struct Update: EndpointType {
        var id: String
        var body: String

        init(id: String, body: String) {
            self.id = id
            self.body = body
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Replies.Path)/\(self.id)" }
        var method: HTTPMethod { return .PUT }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["body"] = self.body

            return parameters
        }

        typealias T = Reply

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["reply"])
        }
    }

    struct Like: EndpointType {
        static let Path = "likes"
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Replies.Like.Path }
        var method: HTTPMethod { return .POST }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["obj_type"] = "reply"
            parameters["obj_id"] = self.id

            return parameters
        }

        typealias T = AnyObject
    }

    struct UndoLike: EndpointType {
        static let Path = "likes"
        var id: String

        init(id: String) {
            self.id = id
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Replies.UndoLike.Path }
        var method: HTTPMethod { return .DELETE }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["obj_type"] = "reply"
            parameters["obj_id"] = self.id

            return parameters
        }

        typealias T = AnyObject
    }
}
