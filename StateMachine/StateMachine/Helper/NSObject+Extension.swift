//
//  NSObject+Extension.swift
//  V2EX
//
//  Created by iShawnWang on 2017/6/30.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
