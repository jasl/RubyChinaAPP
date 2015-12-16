//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation

struct SharedProvider {
    static var instance = Provider(clientID: GlobalConstant.clientId, clientSecret: GlobalConstant.clientSecret, redirect_uris: GlobalConstant.redirectURIs)
}
