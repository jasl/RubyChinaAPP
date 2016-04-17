//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import MoyaX

extension RubyChinaV3 {
    struct Users {
        static let Path = "users"
    }
}

extension RubyChinaV3.Users {
    struct Listing: EndpointType {
        let limit: Int?

        init(limit: Int? = nil) {
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        let path = RubyChinaV3.Users.Path
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            if let limit = self.limit {
                parameters["limit"] = limit
            }

            return parameters
        }

        typealias DeserializedType = [User]

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["users"])
        }
    }

    struct Get: EndpointType {
        let login: String

        init(login: String) {
            self.login = login
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)" }

        typealias DeserializedType = User

        func parseResponse(json: JSON) -> DeserializedType? {
            if json["user"].type == .Null {
                return nil
            }

            var user = DeserializedType(byJSON: json["user"])!

            if let isFollowed = json["meta"]["followed"].bool {
                user.isFollowed = isFollowed
            }
            if let isBlocked = json["meta"]["blocked"].bool {
                user.isBlocked = isBlocked
            }

            return user
        }
    }

    struct Topics: EndpointType, OffsetPaginatable {
        enum OrderBy: String {
            case Recent = "recent"
            case Likes = "likes"
            case Replies = "replies"
        }

        let login: String
        let orderBy: OrderBy?
        var offset: Int
        var limit: Int

        init(login: String, orderBy: OrderBy? = nil, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.orderBy = orderBy
            self.offset = offset
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/topics" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            if let orderBy = self.orderBy {
                parameters["order"] = orderBy.rawValue
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

    struct Replies: EndpointType, OffsetPaginatable {
        enum OrderBy: String {
            case Recent = "recent"
        }

        let login: String
        let orderBy: OrderBy?
        var offset: Int
        var limit: Int

        init(login: String, orderBy: OrderBy? = nil, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.orderBy = orderBy
            self.offset = offset
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/replies" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            if let orderBy = self.orderBy {
                parameters["order"] = orderBy.rawValue
            }

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias DeserializedType = [Reply]

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["replies"])
        }
    }

    struct Favorites: EndpointType, OffsetPaginatable {
        let login: String
        var offset: Int
        var limit: Int

        init(login: String, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/favorites" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias DeserializedType = [Topic]

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["topics"])
        }
    }

    struct Following: EndpointType, OffsetPaginatable {
        let login: String
        var offset: Int
        var limit: Int

        init(login: String, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/following" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias DeserializedType = [User]

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["users"])
        }
    }

    struct Followers: EndpointType, OffsetPaginatable {
        let login: String
        var offset: Int
        var limit: Int

        init(login: String, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/followers" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias DeserializedType = [User]

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["users"])
        }
    }

    struct Blocked: EndpointType, OffsetPaginatable {
        let login: String
        var offset: Int
        var limit: Int

        init(login: String, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/blocked" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias DeserializedType = [User]

        func parseResponse(json: JSON) -> DeserializedType? {
            return DeserializedType(byJSON: json["users"])
        }
    }

    struct Follow: EndpointType {
        let login: String

        init(login: String) {
            self.login = login
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/follow" }
        let method = HTTPMethod.POST

        typealias DeserializedType = AnyObject
    }

    struct UnFollow: EndpointType {
        let login: String

        init(login: String) {
            self.login = login
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/unfollow" }
        let method = HTTPMethod.POST

        typealias DeserializedType = AnyObject
    }

    struct Block: EndpointType {
        let login: String

        init(login: String) {
            self.login = login
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/block" }
        let method = HTTPMethod.POST

        typealias DeserializedType = AnyObject
    }

    struct UnBlock: EndpointType {
        let login: String

        init(login: String) {
            self.login = login
        }

        let baseURL = RubyChinaV3.BaseURL
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/unblock" }
        let method = HTTPMethod.POST

        typealias DeserializedType = AnyObject
    }
}
