//
// Created by 姜军 on 7/14/15.
// Copyright (c) 2015 KnewOne. All rights reserved.
//

import Foundation
import UIKit

func selectedRowAtIndexPathFor(tableView: UITableView, sender: UIView) -> Int? {
    switch sender {
    case let sender as UITableViewCell:
        return tableView.indexPathForCell(sender)?.row
    case let sender as UIEmbedsInCellButton:
        let cell = sender.superview?.superview as! UITableViewCell
        return tableView.indexPathForCell(cell)?.row
    default:
        return nil
    }
}
