//
//  ViewStateMachine.swift
//  StateMachine
//
//  Created by iShawnWang on 2017/7/10.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import Foundation
import UIKit

/// Delegate
protocol ViewStateMachineDelegate {
    associatedtype TheViewState
    
    func canEnter(state:TheViewState) -> Bool
    func transit(from:TheViewState?, to:TheViewState,container:UIView)
}


/// Default Impl
extension ViewStateMachineDelegate{
    func canEnter(state:TheViewState) -> Bool{
        return true
    }
}


/// StateMachine with a container to show different view in different state
class ViewStateMachine<T:ViewStateMachineDelegate>{

    let superView:UIView

    let container:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let delegate:T
    
    lazy var stateMachine:StateMachine<ViewStateMachine> = {
        let s = StateMachine<ViewStateMachine>(delegate: self)
        return s
    }()
    
    init(superView:UIView,delegate:T) {
        self.delegate = delegate
        self.superView = superView
        
        // add a "containerView" to fill superView
        self.superView.addSubview(container)
        container.alpha = 0.0

        let item = container
        let toItem = superView
        let fillParentConstraints = [NSLayoutConstraint(item: item,
                                                        attribute: .leading,
                                                        relatedBy: .equal,
                                                        toItem: toItem,
                                                        attribute: .leading,
                                                        multiplier: 1.0,
                                                        constant: 0.0),
                                     NSLayoutConstraint(item: item,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: toItem,
                                                        attribute: .trailing,
                                                        multiplier: 1.0,
                                                        constant: 0.0),
                                     NSLayoutConstraint(item: item,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: toItem,
                                                        attribute: .top,
                                                        multiplier: 1.0,
                                                        constant: 0.0),
                                     NSLayoutConstraint(item: item,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: toItem,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: 0.0)]
        superView.addConstraints(fillParentConstraints)
    }
    
    @discardableResult
    public func enter(state:T.TheViewState) -> Bool {
        return self.stateMachine.enter(state: state)
    }
}

extension ViewStateMachine:StateMachineDelegate{
    typealias State = T.TheViewState
    
    func canEnter(state: T.TheViewState) -> Bool {
        return self.delegate.canEnter(state: state)
    }
    
    func transit(from: T.TheViewState?, to: T.TheViewState) {
        self.delegate.transit(from: from, to: to, container: container)
    }
}

class DefaultViewStateMachineDelegate: ViewStateMachineDelegate {
    typealias TheViewState = ViewState

    func transit(from: ViewState?, to: ViewState, container: UIView) {
        container.subviews.forEach{$0.removeFromSuperview()}
        
        switch to {
            
        case .failed(let v),
             .noData(let v),
             .data(let v):
            container.addSubview(v)
            
            // center state View
            let item = v
            let toItem = container
            
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
            
            container.addConstraints([centerXConstraint,centerYConstraint])
            container.alpha = 1.0
        default:
            container.alpha = 0.0
        }
    }
}
