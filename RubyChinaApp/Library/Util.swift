//
// Created by 姜军 on 7/14/15.
// Copyright (c) 2015 KnewOne. All rights reserved.
//

import Foundation

func debugDescriptionFor<T>(object: T) -> String {
    let mirror = Mirror(reflecting: object)

    var children = [(label: String?, value: Any)]()
    let mirrorChildrenCollection = AnyRandomAccessCollection(mirror.children)!
    children += mirrorChildrenCollection

    var currentMirror = mirror
    while let superclassChildren = currentMirror.superclassMirror()?.children {
        let randomCollection = AnyRandomAccessCollection(superclassChildren)!
        children += randomCollection
        currentMirror = currentMirror.superclassMirror()!
    }

    var filteredChildren = [(label: String?, value: Any)]()
    for (optionalPropertyName, value) in children {
        if !optionalPropertyName!.containsString("notMapped_") {
            filteredChildren += [(optionalPropertyName, value)]
        }
    }

    let size = filteredChildren.count
    var index = 0

    var str = "<\(String(T))"

    for (optionalPropertyName, value) in filteredChildren {
        let propertyName = optionalPropertyName!
        let property = Mirror(reflecting: value)

        str += " \(propertyName)="

        if let propertyValue = value as? CustomDebugStringConvertible {
            str += propertyValue.debugDescription
        } else {
            let propertyValue = String(value)

            if propertyValue == "nil" {
                str += "nil"
            } else {
                str += propertyValue
            }
        }

        index++
    }

    str += ">"

    return str
}

