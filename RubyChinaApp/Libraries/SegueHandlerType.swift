//
// Created by 姜军 on 2/15/16.
// Copyright (c) 2016 RubyChina. All rights reserved.
//

import Foundation
import UIKit

// From WWDC2015-414
protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }

    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
                  segueIdentifier = SegueIdentifier(rawValue: identifier)
        else {
            fatalError("Invalid segue identifier \(segue.identifier)")
        }

        return segueIdentifier
    }
}

