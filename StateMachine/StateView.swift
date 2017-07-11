//
//  StateView.swift
//  StateMachine
//
//  Created by iShawnWang on 2017/7/10.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import Foundation
import UIKit

class StateView: UIView {
    @IBOutlet weak var label: UILabel!
    static func loadFromXib() -> StateView {
        let v = Bundle.main.loadNibNamed(self.className, owner: nil, options: nil)!.first as! StateView
        v.translatesAutoresizingMaskIntoConstraints = false
        v.label.textColor = UIColor.red
        return v
    }
}
