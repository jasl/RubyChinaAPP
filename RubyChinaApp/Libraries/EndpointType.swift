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
    func doRequest(provider: Provider, completion: (result: APIResult<T>) -> ()) -> NetworkAbstraction.Cancellable
}

extension EndpointType {
    func doRequest(provider: Provider = Provider.defaultInstance(), completion: (result: APIResult<T>) -> ()) -> NetworkAbstraction.Cancellable {
        return provider.request(self) { result in
            var apiResult: APIResult<T>

            switch result {
            case let .Success(response):
                let json = response.mapSwiftyJSON()
                
                if let _ = json["ok"].int {
                    apiResult = .Ok
                } else if let errorMessage = json["error"].string {
                    apiResult = .Failure(APIError(statusCode: response.statusCode, message: errorMessage))
                } else if let entity = self.buildEntity(json) {
                    apiResult = .Success(entity)
                } else {
                    apiResult = .Ok
                }
            case let .Failure(error):
                apiResult = .NetworkError(error)
            }

            completion(result: apiResult)
        }
    }
}

extension EndpointType {
    func buildEntity(json: JSON) -> T? {
        return nil
    }
}
