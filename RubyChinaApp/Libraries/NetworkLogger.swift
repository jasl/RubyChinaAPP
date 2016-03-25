//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import MoyaX
import Result

/// Logs network activity (outgoing requests and incoming responses).
class NetworkLogger: MiddlewareType {

    func willSendRequest(target: TargetType, endpoint: Endpoint) {
        logger.info("Sending request: \(endpoint.URL.absoluteString)")
    }

    func didReceiveResponse(target: TargetType, response: Result<Response, Error>) {
        switch response {
        case let .Success(response):
            logger.info("Received response(\(response.statusCode ?? 0)) from \(response.response!.URL?.absoluteString ?? String()).")
        case .Failure(_):
            logger.error("Got error")
        }

    }
}
