//
// Created by 姜军 on 12/20/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import MoyaX
import p2_OAuth2
import Alamofire

class Provider {
    var timeOut: NSTimeInterval = 15

    private var oauthClient: OAuth2CodeGrant!
    private var provider: MoyaXProvider!

    var afterAuthorizeSuccess: ((parameters: OAuth2JSON) -> Void)? {
        get { return oauthClient.onAuthorize }
        set(closure) { oauthClient.onAuthorize = closure }
    }
    var afterAuthorizeFailure: ((error: ErrorType?) -> Void)? {
        get { return oauthClient.onFailure }
        set(closure) { oauthClient.onFailure = closure }
    }
    var afterAuthorizeSuccessOrFailure: ((wasFailure: Bool, error: ErrorType?) -> Void)? {
        get { return oauthClient.afterAuthorizeOrFailure }
        set(closure) { oauthClient.afterAuthorizeOrFailure = closure }
    }

    var authorizeContext: AnyObject? {
        get { return oauthClient.authConfig.authorizeContext }
        set(context) { oauthClient.authConfig.authorizeContext = context }
    }

    init(clientID: String, clientSecret: String, redirect_uris: [String],
         scope: String = "",
         authorizeEmbedded: Bool = true,
         middlewares: [MiddlewareType] = []) {
        oauthClient = OAuth2CodeGrant(settings: [
                "client_id": clientID,
                "client_secret": clientSecret,
                "authorize_uri": "https://ruby-china.org/oauth/authorize",
                "token_uri": "https://ruby-china.org/oauth/token",
                "scope": scope,
                "redirect_uris": redirect_uris,
                "secret_in_body": false,
                "verbose": true,
        ] as OAuth2JSON)

        let prepareForEndpointClosure: Endpoint -> () = { endpoint in
            // Signing
            if let accessToken = self.oauthClient!.clientConfig.accessToken where !accessToken.isEmpty {
                endpoint.headerFields["Authorization"] = "Bearer \(accessToken)"
            }
        }

        provider = MoyaXProvider(backend: AlamofireBackend(manager: alamofireManager(self.timeOut)),
                                 prepareForEndpoint: prepareForEndpointClosure,
                                 middlewares: middlewares)

        oauthClient.authConfig.authorizeEmbedded = authorizeEmbedded
    }

    func request(target: TargetType, completion: MoyaX.Completion) -> Cancellable {
        return provider.request(target, completion: completion)
    }

    func authorize(params: OAuth2StringDict? = nil) {
        oauthClient.authorize(params: params)
    }

    func resetAuthorize() {
        oauthClient.forgetTokens()
    }

    func handleRedirectURL(redirect: NSURL) {
        oauthClient.handleRedirectURL(redirect)
    }

    func isAuthorized() -> Bool {
        if let accessToken = self.oauthClient!.clientConfig.accessToken where !accessToken.isEmpty {
            return true
        } else {
            return false
        }
    }
}

func alamofireManager(timeOut: NSTimeInterval = 15) -> Manager {
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = timeOut
    configuration.timeoutIntervalForResource = timeOut

    let manager = Manager(configuration: configuration)
    return manager
}
