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
        let topicId: String
        var offset: Int
        var limit: Int

        init(topicId: String, offset: Int = 0, limit: Int = 20) {
            self.topicId = topicId
            self.offset = offset
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.topicId)/\(RubyChinaV3.Replies.Path)" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias DeserializedType = [Reply]

        func parseResponse(json: JSON) -> DeserializedType? {
            var topics = DeserializedType(byJSON: json["replies"])

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
        let topicId: String
        let body: String

        init(topicId: String, body: String) {
            self.topicId = topicId
            self.body = body
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Topics.Path)/\(self.topicId)/\(RubyChinaV3.Replies.Path)" }
        let method = HTTPMethod.POST
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["body"] = self.body

            return parameters
        }

        typealias DeserializedType = Reply

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["reply"])
        }
    }

    struct Get: EndpointType {
        let id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Replies.Path)/\(self.id)" }

        typealias DeserializedType = Reply

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["reply"])
        }
    }

    struct Destroy: EndpointType {
        let id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Replies.Path)/\(self.id)" }
        let method = HTTPMethod.DELETE

        typealias DeserializedType = AnyObject
    }

    struct Update: EndpointType {
        let id: String
        let body: String

        init(id: String, body: String) {
            self.id = id
            self.body = body
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Replies.Path)/\(self.id)" }
        let method = HTTPMethod.PUT
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["body"] = self.body

            return parameters
        }

        typealias DeserializedType = Reply

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["reply"])
        }
    }

    struct Like: EndpointType {
        let id: String

        init(id: String) {
            self.id = id
        }

        let baseURL = RubyChinaV3.BaseURL
        let path = "likes"
        let method = HTTPMethod.POST
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["obj_type"] = "reply"
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

            parameters["obj_type"] = "reply"
            parameters["obj_id"] = self.id

            return parameters
        }

        typealias DeserializedType = AnyObject
    }
}
