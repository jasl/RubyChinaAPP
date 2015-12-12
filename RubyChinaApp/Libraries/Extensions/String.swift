//
// Created by 姜军 on 12/12/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation

extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}
