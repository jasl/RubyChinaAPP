//
//  TopicsTableViewController.swift
//  RubyChinaApp
//
//  Created by 姜军 on 12/24/15.
//  Copyright © 2015 RubyChina. All rights reserved.
//

import UIKit
import MJRefresh

class TopicsTableViewController: UIViewController, UITableViewDelegate {

    // MARK: Properties
    @IBOutlet weak var topicsTableView: UITableView!
    let cellIdentifier = "TopicsTableViewCell"
    var topicsPager = TopicsPager(withPerPage: 10)
    var topics = [Topic]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.topicsTableView.delegate = self
        self.topicsTableView.dataSource = self

        self.topicsTableView.separatorColor = UIColor.clearColor()

        self.topicsTableView.estimatedRowHeight = 72
        self.topicsTableView.rowHeight = UITableViewAutomaticDimension

        var tableViewHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "pullDownRefreshingAction")
        tableViewHeader.lastUpdatedTimeLabel!.hidden = true

        self.topicsTableView.mj_header = tableViewHeader

        var tableViewFooter = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "pullUpRefreshingAction")

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

    // MARK: - Table view data source

    func pullDownRefreshingAction() {
        defer {
            self.topicsTableView.mj_header.endRefreshing()
        }

        self.topicsPager.loadFresh() { result in
            switch result {
            case let .Success(topics):
                self.topics = topics
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

        if self.topicsPager.hasReachedTheEnd {
            return
        }

        self.topicsPager.loadMore { result in
            switch result {
            case let .Success(topics):
                self.topics.appendContentsOf(topics)
                self.topicsTableView.reloadData()
            case let .Failure(error):
                dump(error)
            default:
                dump(result)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension TopicsTableViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! TopicsTableViewCell
        let topic = self.topics[indexPath.row]

        // Configure the cell...
        cell.titleLabel.text = topic.title
        cell.authorNameLabel.text = topic.user.login
        cell.nodeNameLabel.text = topic.nodeName
        cell.repliesCountLabel.text = String(topic.repliesCount)

        //cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);

        return cell
    }
}
