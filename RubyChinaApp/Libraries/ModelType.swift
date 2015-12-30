//
// Created by 姜军 on 12/31/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation

protocol ModelType: SwiftyJSONMappable, Equatable, Hashable {
    var identifier: String { get }
}

extension ModelType {
    var hashValue: Int {
        return self.identifier.hashValue
    }
}

func ==<T: ModelType>(lhs: T, rhs: T) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
