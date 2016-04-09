//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import MoyaX

/// Logs network activity (outgoing requests and incoming responses).
class NetworkLogger: Middleware {

    func willSendRequest(target: Target, endpoint: Endpoint) {
        logger.info("Sending request: \(endpoint.URL.absoluteString)")
    }

    func didReceiveResponse(target: Target, response: Result<Response, Error>) {
        switch response {
        case let .Response(response):
            logger.info("Received response(\(response.statusCode ?? 0)) from \(response.response!.URL?.absoluteString ?? String()).")
        case .Incomplete(_):
            logger.error("Got error")
        }

    }
}
