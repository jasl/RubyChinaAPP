//
// Created by 姜军 on 12/28/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import NetworkAbstraction

// TopicsPager 是对 RubyChinaV3.Topics.Listing 的封装,
// 这种返回集合的 API 通常用于 UITableView 等列表页面, 通过 Pager 类可以很好的屏蔽掉加载新旧数据的逻辑,
// 其仅暴露 UI关心的加载新数据(下拉刷新)和加载更早的数据(下拉加载更多), 如游标或指针的维持,
// 同样的, Pager 返回的形式与正常途径调用的 Endpoint 的返回值及回调函数签名一致
// 需要注意的是, 虽然 RubyChina 的 API 并没有使用游标方式实现, 但原理相同, 若采取游标方式实现分页, 可简化 Pager 的实现
// 这里必须是基于类实现, 因为要在 Endpoint 的异步回调中修改自身状态
class TopicsPager {
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

    private var endpoint: RubyChinaV3.Topics.Listing

    init(withPage page: Int = 1, withType type: RubyChinaV3.Topics.Listing.TypeFieldValue? = nil, withNodeId nodeId: String? = nil, withPerPage perPage: Int = 20) {
        self.perPage = perPage
        self.currentPage = page

        self.endpoint = RubyChinaV3.Topics.Listing(type: type, nodeId: nodeId, limit: self.perPage)
        self.endpoint.offset = self.currentOffset
    }

    func loadFresh(completion: (result: APIResult<[Topic]>) -> ()) -> NetworkAbstraction.Cancellable {
        self.currentPage = 1
        self.isNoMoreData = false

        return self.endpoint.doRequest() { result in
            if case .Success(let topics) = result {
                if topics.isEmpty {
                    self.isNoMoreData = true
                } else {
                    self.currentPage += 1
                }
            }

            completion(result: result)
        }
    }

    func loadMore(completion: (result: APIResult<[Topic]>) -> ()) -> NetworkAbstraction.Cancellable {
        return self.endpoint.doRequest() { result in
            if case .Success(let topics) = result {
                if topics.isEmpty {
                    self.isNoMoreData = true
                } else {
                    self.currentPage += 1
                }
            }

            completion(result: result)
        }
    }
}
