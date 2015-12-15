//
// Created by 姜军 on 12/13/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import NetworkAbstraction
import p2_OAuth2

struct RubyChinaV3 {
    static let BaseURL = NSURL(string: "https://ruby-china.org/api/v3/")!
}

class RubyChinaV3Provider {
    private let oauthClient: OAuth2CodeGrant
    private let provider: APIProvider

    var afterAuthorizeSuccess: ((parameters: OAuth2JSON) -> Void)? = nil
    var afterAuthorizeFailure: ((error: ErrorType?) -> Void)? = nil
    var afterAuthorizeSuccessOrFailure: ((wasFailure: Bool, error: ErrorType?) -> Void)? = nil

    var authorizeContext: AnyObject? {
        get { return oauthClient.authConfig.authorizeContext }
        set(context) { oauthClient.authConfig.authorizeContext = context }
    }

    init(clientID: String, clientSecret: String, redirect_uris: [String],
         scope: String = "",
         authorizeEmbedded: Bool = true,
         plugins: [PluginType] = []) {
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

        provider = APIProvider()

        provider.requestClosure = { (endpoint: Endpoint, done: NSURLRequest -> Void) in
            self.signingRequest(endpoint, done: done)
        }

        oauthClient.authConfig.authorizeEmbedded = authorizeEmbedded

        oauthClient.onAuthorize = { parameters in
            self.afterAuthorizeSuccess?(parameters: parameters)
        }
        oauthClient.onFailure = { error in
            self.afterAuthorizeFailure?(error: error)
        }
        oauthClient.afterAuthorizeOrFailure = { (wasFailure: Bool, error: ErrorType?) in
            self.afterAuthorizeSuccessOrFailure?(wasFailure: wasFailure, error: error)
        }
    }

    private func signingRequest(endpoint: Endpoint, done: NSURLRequest -> Void) {
        let request = endpoint.mutableURLRequest

        if let accessToken = self.oauthClient.clientConfig.accessToken where !accessToken.isEmpty {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        done(request)
    }

    func request(target: TargetType, completion: NetworkAbstraction.Completion) -> Cancellable {
        return provider.request(target, completion: completion)
    }

    func authorize(params: OAuth2StringDict? = nil, autoDismiss: Bool = true) {
        oauthClient.authorize(params: params, autoDismiss: autoDismiss)
    }

    func resetAuthorize() {
        oauthClient.forgetTokens()
    }

    func handleRedirectURL(redirect: NSURL) {
        oauthClient.handleRedirectURL(redirect)
    }
}
