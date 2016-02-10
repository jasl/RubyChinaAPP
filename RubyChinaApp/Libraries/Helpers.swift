//
// Created by 姜军 on 7/14/15.
// Copyright (c) 2015 KnewOne. All rights reserved.
//

import Foundation
import UIKit

func selectedRowAtIndexPathFor(tableView: UITableView, sender: AnyObject?) -> Int? {
    guard let sender = sender as? UIView else { return nil }

    switch sender {
    case let sender as UITableViewCell:
        return tableView.indexPathForCell(sender)?.row
    case let sender as EmbedsInTableViewCellUIButton:
        guard let cell = recurisiveSearchParentViewUntil(UITableViewCell.self, currentView: sender) else { return nil }
        return tableView.indexPathForCell(cell)?.row
    default:
        return nil
    }
}

func recurisiveSearchParentViewUntil<T: UIView>(type: T.Type, currentView: UIView?) -> T? {
    guard let currentView = currentView else { return nil }

    if let view = currentView as? T {
        return view
    }

    return recurisiveSearchParentViewUntil(type, currentView: currentView.superview)
}
