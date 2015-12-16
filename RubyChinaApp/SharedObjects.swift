//
// Created by 姜军 on 12/17/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import XCGLogger

extension Provider {
    public class func defaultInstance() -> Provider {
        struct statics {
            static let instance: Provider = Provider(clientID: GlobalConstant.clientId,
                                                     clientSecret: GlobalConstant.clientSecret,
                                                     redirect_uris: GlobalConstant.redirectURIs,
                                                     plugins: [NetworkLogger()])
        }

        return statics.instance
    }
}

let logger = XCGLogger.defaultInstance()
let provider = Provider.defaultInstance()
