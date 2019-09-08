//
//  Helper.swift
//  Combine101
//
//  Created by Paul Solt on 9/8/19.
//  Copyright © 2019 Paul Solt. All rights reserved.
//

import Foundation

// TODO: Fix time formatting (timezone?)
var dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .long
    formatter.dateFormat = "mm:ss.SS"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}()
