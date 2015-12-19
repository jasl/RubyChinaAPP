//
// Created by 姜军 on 12/18/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import NetworkAbstraction

protocol EndpointType: TargetType {
    typealias T

    func buildEntity(json: JSON) -> T?
    func doRequest(provider: Provider, callback: (result: APIResult<T>) -> ()) -> NetworkAbstraction.Cancellable
}

extension EndpointType {
    func doRequest(provider: Provider = Provider.defaultInstance(), callback: (result: APIResult<T>) -> ()) -> NetworkAbstraction.Cancellable {
        return provider.request(self) { result in
            var apiResult: APIResult<T>

            switch result {
            case let .Success(response):
                let json = response.mapSwiftyJSON()

                if let ok = json["ok"].int {
                    apiResult = .Ok
                } else if let error = APIError(byJSON: json["error"]) {
                    apiResult = .Failure(error)
                } else if let entity = self.buildEntity(json) {
                    apiResult = .Success(entity)
                } else {
                    apiResult = .Ok
                }
            case let .Failure(error):
                apiResult = .NetworkError(error)
            }

            callback(result: apiResult)
        }
    }
}

extension EndpointType {
    func buildEntity(json: JSON) -> T? {
        return nil
    }
}
