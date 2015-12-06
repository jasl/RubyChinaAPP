//
//  RestClient.swift
//  Less
//
//  Created by 姜军 on 7/9/15.
//  Copyright (c) 2015 KnewOne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import XCGLogger

class RestClient {
    let baseURL: NSURL!
    var defaultHeaders: [String:String] = [:]
    var timeOut: NSTimeInterval = 15
    var logger = XCGLogger.defaultInstance()

    init(baseURL: String) {
        self.baseURL = NSURL(string: baseURL)
    }

    func request(endpointURL: String,
                 method: Alamofire.Method,
                 withParameters parameters: [String:AnyObject] = [:],
                 withHeaders headers: [String:String] = [:],
                 completionHandler: (NSURLRequest, NSHTTPURLResponse?, JSON, ErrorType?) -> Void) -> Request {
        let mutableURLRequest = NSMutableURLRequest(URL: baseURL.URLByAppendingPathComponent(endpointURL))

        mutableURLRequest.timeoutInterval = timeOut
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for (key, value) in defaultHeaders {
            mutableURLRequest.setValue(value, forHTTPHeaderField: key)
        }
        for (key, value) in headers {
            mutableURLRequest.setValue(value, forHTTPHeaderField: key)
        }

        let encodingMethod: Alamofire.ParameterEncoding = {
            if method == .GET {
                return .URL
            } else {
                return .JSON
            }
        }()

        let encodedRequest = encodingMethod.encode(mutableURLRequest, parameters: parameters).0

        logRequest(encodedRequest)

        return Alamofire
        .request(encodedRequest)
        .responseSwiftyJSON(completionHandler: completionHandler)
    }

    func get(endpointURL: String,
             withParameters parameters: [String:AnyObject] = [:],
             withHeaders headers: [String:String] = [:],
             completionHandler: (NSURLRequest, NSHTTPURLResponse?, JSON, ErrorType?) -> Void) -> Request {
        return request(endpointURL, method: .GET, withParameters: parameters, withHeaders: headers, completionHandler: completionHandler)
    }

    private func logRequest(request: NSURLRequest, functionName: String = __FUNCTION__) {
        logger.info("Starting \(request.HTTPMethod!) \"\(request.URL!)\"", functionName: functionName)
        logger.info("  Headers: \(request.allHTTPHeaderFields!)", functionName: functionName)
        if let requestBody = request.HTTPBody {
            if !requestBody.description.isEmpty {
                logger.info("  Body: \(requestBody.description)", functionName: functionName)
            }
        }
    }
}
