//
// Created by 姜军 on 1/24/16.
// Copyright (c) 2016 RubyChina. All rights reserved.
//

import Foundation
import NetworkAbstraction

protocol OffsetPaginatable {
    var offset: Int { get set }
    var limit: Int { get set }

    typealias T: CollectionType
}

// Abstract class
class OffsetPager<T: protocol<EndpointType, OffsetPaginatable>> {
    let perPage: Int

    var currentPage: Int {
        didSet {
            self.endpoint.offset = self.currentOffset
        }
    }
    var currentOffset: Int {
        return (self.currentPage - 1) * self.perPage
    }

    private var isNoMoreData = false
    var hasReachedTheEnd: Bool {
        get {
            return self.isNoMoreData
        }
    }

    private var endpoint: T

    init(endpoint: T, withPage page: Int = 1, withPerPage perPage: Int = 20) {
        self.perPage = perPage
        self.currentPage = page

        self.endpoint = endpoint
        self.endpoint.offset = self.currentOffset
        self.endpoint.limit = perPage
    }

    func loadFresh(completion: (result: APIResult<T.T>) -> ()) -> NetworkAbstraction.Cancellable {
        self.currentPage = 1
        self.isNoMoreData = false

        return self.endpoint.doRequest() { result in
            if case .Success(let entities) = result {
                if entities.isEmpty {
                    self.isNoMoreData = true
                } else {
                    self.currentPage += 1
                }
            }

            completion(result: result)
        }
    }

    func loadMore(completion: (result: APIResult<T.T>) -> ()) -> NetworkAbstraction.Cancellable {
        return self.endpoint.doRequest() { result in
            if case .Success(let entities) = result {
                if entities.isEmpty {
                    self.isNoMoreData = true
                } else {
                    self.currentPage += 1
                }
            }

            completion(result: result)
        }
    }
}
