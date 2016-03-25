//
//  TopicsViewController.swift
//  RubyChinaApp
//
//  Created by 姜军 on 12/24/15.
//  Copyright © 2015 RubyChina. All rights reserved.
//

import UIKit
import MJRefresh

class TopicsViewController: UIViewController, SegueHandlerType {

    enum SegueIdentifier: String {
        case ShowTopicDetailSegue = "ShowTopicDetailSegue"
        case ShowUserDetailSegue = "ShowUserDetailSegue"
    }

    // MARK: Properties
    var topicsPager = TopicsPager(withPerPage: 10)
    var topicViewModels = [TopicCellViewModel]()

    @IBOutlet weak var topicsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.topicsTableView.delegate = self
        self.topicsTableView.dataSource = self

        self.topicsTableView.separatorColor = UIColor.clearColor()

        self.topicsTableView.estimatedRowHeight = 72
        self.topicsTableView.rowHeight = UITableViewAutomaticDimension

        let tableViewHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(TopicsViewController.pullDownRefreshingAction))
        tableViewHeader.lastUpdatedTimeLabel!.hidden = true

        self.topicsTableView.mj_header = tableViewHeader

        let tableViewFooter = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(TopicsViewController.pullUpRefreshingAction))

        self.topicsTableView.mj_footer = tableViewFooter

        self.topicsTableView.mj_header.beginRefreshing()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let sender = sender as? UIView else {
            fatalError("Sender is nil")
        }

        guard let index = selectedRowAtIndexPathFor(self.topicsTableView, sender: sender) else {
            fatalError("Invalid index")
        }

        let identifier = segueIdentifierForSegue(segue)
        let viewModel = self.topicViewModels[index]

        switch identifier {
        case .ShowTopicDetailSegue:
            let destination = segue.destinationViewController as! TopicDetailViewController
            viewModel.applyTo(destination)
        case .ShowUserDetailSegue:
            let destination = segue.destinationViewController as! UIViewController
            destination.title = viewModel.authorName
        }
    }
}

extension TopicsViewController: UITableViewDataSource {
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topicViewModels.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(TopicsTableViewCell), forIndexPath: indexPath) as! TopicsTableViewCell

        return cell
    }
}

extension TopicsViewController: UITableViewDelegate {
    // MARK: - Table view delegation

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let topicCell = cell as! TopicsTableViewCell
        let viewModel = self.topicViewModels[indexPath.row]

        viewModel.applyTo(topicCell)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        defer {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}

extension TopicsViewController {
    func pullDownRefreshingAction() {
        defer {
            self.topicsTableView.mj_header.endRefreshing()
        }

        self.topicsPager.loadFresh() {
            result in
            switch result {
            case let .Success(topics):
                self.topicViewModels = toTopicCellViewModel(topics)

                self.topicsTableView.reloadData()
            case let .Failure(error):
                dump(error)
            default:
                dump(result)
            }
        }
    }

    func pullUpRefreshingAction() {
        defer {
            self.topicsTableView.mj_footer.endRefreshing()
        }

        if self.topicsPager.isNoMoreData {
            return
        }

        self.topicsPager.loadMore {
            result in
            switch result {
            case let .Success(topics):
                self.topicViewModels.appendContentsOf(toTopicCellViewModel(topics))

                self.topicsTableView.reloadData()
            case let .Failure(error):
                dump(error)
            default:
                dump(result)
            }
        }
    }
}
