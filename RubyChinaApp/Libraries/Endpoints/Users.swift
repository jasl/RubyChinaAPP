//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import NetworkAbstraction

extension RubyChinaV3 {
    struct Users {
        static let Path = "users"
    }
}

extension RubyChinaV3.Users {
    struct Listing: TargetType {
        var limit: Int?

        init(limit: Int? = nil) {
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return RubyChinaV3.Users.Path }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

            if let limit = self.limit {
                parameters["limit"] = limit
            }

            return parameters
        }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Get: TargetType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Topics: TargetType {
        enum OrderByValue: String {
            case Recent = "recent"
            case Likes = "likes"
            case Replies = "replies"
        }

        var login: String
        var orderBy: OrderByValue?
        var offset: Int?
        var limit: Int?

        init(login: String, orderBy: OrderByValue? = nil, offset: Int? = nil, limit: Int? = nil) {
            self.login = login
            self.orderBy = orderBy
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/topics" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

            if let orderBy = self.orderBy {
                parameters["order"] = orderBy.rawValue
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

    struct Replies: TargetType {
        enum OrderByValue: String {
            case Recent = "recent"
        }

        var login: String
        var orderBy: OrderByValue?
        var offset: Int?
        var limit: Int?

        init(login: String, orderBy: OrderByValue? = nil, offset: Int? = nil, limit: Int? = nil) {
            self.login = login
            self.orderBy = orderBy
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/replies" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

            if let orderBy = self.orderBy {
                parameters["order"] = orderBy.rawValue
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

    struct Favorites: TargetType {
        var login: String
        var offset: Int?
        var limit: Int?

        init(login: String, offset: Int? = nil, limit: Int? = nil) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/favorites" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

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

    struct Following: TargetType {
        var login: String
        var offset: Int?
        var limit: Int?

        init(login: String, offset: Int? = nil, limit: Int? = nil) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/following" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

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

    struct Followers: TargetType {
        var login: String
        var offset: Int?
        var limit: Int?

        init(login: String, offset: Int? = nil, limit: Int? = nil) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/followers" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

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

    struct Blocked: TargetType {
        var login: String
        var offset: Int?
        var limit: Int?

        init(login: String, offset: Int? = nil, limit: Int? = nil) {
            self.login = login
            self.offset = offset
            self.limit = limit
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/blocked" }
        var method: NetworkAbstraction.Method { return .GET }
        var parameters: [String: AnyObject]? {
            var parameters = [String: AnyObject]()

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


    struct Follow: TargetType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/follow" }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct UndoFollow: TargetType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/unfollow" }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct Block: TargetType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/block" }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }

    struct UndoBlock: TargetType {
        var login: String

        init(login: String) {
            self.login = login
        }

        var baseURL: NSURL { return RubyChinaV3.BaseURL }
        var path: String { return "\(RubyChinaV3.Users.Path)/\(self.login)/unblock" }
        var method: NetworkAbstraction.Method { return .POST }
        var parameters: [String: AnyObject]? { return nil }
        var parameterEncoding: NetworkAbstraction.ParameterEncoding { return .URL }
    }
}
