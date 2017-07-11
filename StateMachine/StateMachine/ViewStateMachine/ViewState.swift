//
//  ViewState.swift
//  StateMachine
//
//  Created by iShawnWang on 2017/7/11.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import Foundation
import UIKit


/// State For View or ViewController
///
/// - empty: default or nothing happen
/// - data: table View blabla has data to show
/// - failed: network failure, DB broken
/// - noData: no collection, no contacts
enum ViewState:StateFul{
    case empty,data(UIView),failed(UIView),noData(UIView)
}

extension ViewState{
    init() {
        self = .empty
    }
    init(failed view:UIView) {
        self = .failed(view)
    }
    init(data view:UIView) {
        self = .data(view)
    }
    init(noData view:UIView) {
        self = .noData(view)
    }
}
