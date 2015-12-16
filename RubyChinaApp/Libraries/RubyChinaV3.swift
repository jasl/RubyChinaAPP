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

class Provider {
    private var oauthClient: OAuth2CodeGrant!
    private var provider: APIProvider!

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

        provider = APIProvider(requestClosure: { (endpoint: Endpoint, done: NSURLRequest -> Void) in
            self.signingRequest(endpoint, done: done)
        })

        oauthClient.authConfig.authorizeEmbedded = authorizeEmbedded
    }

    private func signingRequest(endpoint: Endpoint, done: NSURLRequest -> Void) {
        let request = endpoint.mutableURLRequest

        if let accessToken = self.oauthClient!.clientConfig.accessToken where !accessToken.isEmpty {
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

    func isAuthorized() -> Bool {
        if let accessToken = self.oauthClient!.clientConfig.accessToken where !accessToken.isEmpty {
            return true
        } else {
            return false
        }
    }
}
