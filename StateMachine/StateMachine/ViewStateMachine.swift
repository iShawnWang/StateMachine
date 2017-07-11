//
//  ViewStateMachine.swift
//  StateMachine
//
//  Created by iShawnWang on 2017/7/10.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import Foundation
import UIKit

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

class ViewStateHandler:StateMachineDelegate {
    let container:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
        
    func transit(from: ViewState?, to: ViewState) {
        container.subviews.forEach{$0.removeFromSuperview()}
        
        switch to {
            
        case .failed(let v),
             .noData(let v),
             .data(let v):
                self.container.addSubview(v)
                
                // center state View
                let item = v
                let toItem = self.container
                
                let centerXConstraint = NSLayoutConstraint(item: item,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: toItem,
                                   attribute: .centerX, multiplier: 1.0, constant: 0.0)
                
                let centerYConstraint = NSLayoutConstraint(item: item,
                                   attribute: .centerY,
                                   relatedBy: .equal,
                                   toItem: toItem,
                                   attribute: .centerY, multiplier: 1.0, constant: 0.0)
                
                self.container.addConstraints([centerXConstraint,centerYConstraint])
            self.container.alpha = 1.0
        default:
            self.container.alpha = 0.0
        }
    }
}

class ViewStateMachine: StateMachine<ViewStateHandler> {
    
    let superView:UIView
    
    init(superView:UIView,stateHandler:ViewStateHandler = ViewStateHandler()) {
        self.superView = superView
        super.init(stateHandler: stateHandler)
        
        // add a "containerView" to fill superView
        self.superView.addSubview(stateHandler.container)
        stateHandler.container.alpha = 0.0

        let item = stateHandler.container
        let toItem = superView
        let fillParentConstraints = [NSLayoutConstraint(item: item,
                                                        attribute: .leading,
                                                        relatedBy: .equal,
                                                        toItem: toItem,
                                                        attribute: .leading,
                                                        multiplier: 1.0,
                                                        constant: 0.0),
                                     NSLayoutConstraint(item: stateHandler.container,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: superView,
                                                        attribute: .trailing,
                                                        multiplier: 1.0,
                                                        constant: 0.0),
                                     NSLayoutConstraint(item: stateHandler.container,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: superView,
                                                        attribute: .top,
                                                        multiplier: 1.0,
                                                        constant: 0.0),
                                     NSLayoutConstraint(item: stateHandler.container,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: superView,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: 0.0)]
        superView.addConstraints(fillParentConstraints)
    }
}
