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
        var limit: Int?

        init(limit: Int? = nil) {
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Users.Path }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            if let limit = self.limit {
                parameters["limit"] = limit
            }

            return parameters
        }

        typealias T = [User]

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["users"])
        }
    }

    struct Get: EndpointType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)" }

        typealias T = User

        func parseResponse(json: JSON) -> T? {
            if json["user"].type == .Null {
                return nil
            }

            var user = T(byJSON: json["user"])!

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
        enum OrderByValue: String {
            case Recent = "recent"
            case Likes = "likes"
            case Replies = "replies"
        }

        var login: String
        var orderBy: OrderByValue?
        var offset: Int
        var limit: Int

        init(login: String, orderBy: OrderByValue? = nil, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.orderBy = orderBy
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
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

        typealias T = [Topic]

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["topics"])
        }
    }

    struct Replies: EndpointType, OffsetPaginatable {
        enum OrderByValue: String {
            case Recent = "recent"
        }

        var login: String
        var orderBy: OrderByValue?
        var offset: Int
        var limit: Int

        init(login: String, orderBy: OrderByValue? = nil, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.orderBy = orderBy
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
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

        typealias T = [Reply]

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["replies"])
        }
    }

    struct Favorites: EndpointType, OffsetPaginatable {
        var login: String
        var offset: Int
        var limit: Int

        init(login: String, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/favorites" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias T = [Topic]

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["topics"])
        }
    }

    struct Following: EndpointType, OffsetPaginatable {
        var login: String
        var offset: Int
        var limit: Int

        init(login: String, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/following" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias T = [User]

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["users"])
        }
    }

    struct Followers: EndpointType, OffsetPaginatable {
        var login: String
        var offset: Int
        var limit: Int

        init(login: String, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/followers" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias T = [User]

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["users"])
        }
    }

    struct Blocked: EndpointType, OffsetPaginatable {
        var login: String
        var offset: Int
        var limit: Int

        init(login: String, offset: Int = 0, limit: Int = 20) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/blocked" }
        var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()

            parameters["limit"] = self.limit
            parameters["offset"] = self.offset

            return parameters
        }

        typealias T = [User]

        func parseResponse(json: JSON) -> T? {
            return T(byJSON: json["users"])
        }
    }

    struct Follow: EndpointType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/follow" }
        var method: MoyaX.Method { return .POST }

        typealias T = AnyObject
    }

    struct UndoFollow: EndpointType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/unfollow" }
        var method: MoyaX.Method { return .POST }

        typealias T = AnyObject
    }

    struct Block: EndpointType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/block" }
        var method: MoyaX.Method { return .POST }

        typealias T = AnyObject
    }

    struct UndoBlock: EndpointType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/unblock" }
        var method: MoyaX.Method { return .POST }

        typealias T = AnyObject
    }
}
