//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import NetworkAbstraction

/// Logs network activity (outgoing requests and incoming responses).
class NetworkLogger: PluginType {

    func willSendRequest(request: RequestType, target: TargetType) {
        logger.info("Sending request: \(request.request?.URL?.absoluteString ?? String())")
    }

    func didReceiveResponse(result: Result<NetworkAbstraction.Response, NetworkAbstraction.Error>, target: TargetType) {
        switch result {
        case let .Success(response):
            logger.info("Received response(\(response.statusCode ?? 0)) from \(response.response!.URL?.absoluteString ?? String()).")
        case let .Failure(error):
            switch error {
            case let .ImageMapping(response):
                logger.warning("Received response(\(response.statusCode ?? 0)) but got 'Image Mapping Error' from \(response.response!.URL?.absoluteString ?? String()).")
            case let .JSONMapping(response):
                logger.warning("Received response(\(response.statusCode ?? 0)) but got 'JSON Mapping Error' from \(response.response!.URL?.absoluteString ?? String()).")
            case let .StringMapping(response):
                logger.warning("Received response(\(response.statusCode ?? 0)) but got 'String Mapping Error' from \(response.response!.URL?.absoluteString ?? String()).")
            case let .StatusCode(response):
                logger.warning("Received response(\(response.statusCode ?? 0)) but got 'Status Code Error' from \(response.response!.URL?.absoluteString ?? String()).")
            case let .Data(response):
                logger.warning("Received response(\(response.statusCode ?? 0)) but got 'Data Error' from \(response.response!.URL?.absoluteString ?? String()).")
            case let .Underlying(errorType):
                logger.warning("Underlying Error \(errorType).")
            }
        }

    }
}
