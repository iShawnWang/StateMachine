//
//  StateMachine.swift
//  StateMachine
//
//  Created by iShawnWang on 2017/7/10.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import Foundation

// MARK: Delegate
public protocol StateMachineDelegate{
    associatedtype State
    
    func canEnter(state:State) -> Bool
    func transit(from:State?, to:State)
}

/// Protocol Default Impl
extension StateMachineDelegate{
    func canEnter(state:State) -> Bool{
        return true
    }
}

// MARK: StateMachine
public class StateMachine<T:StateMachineDelegate> {
    
    public let delegate:T
    
    public init(delegate:T) {
        self.delegate = delegate
    }
    
    public var currentState:T.State?{
        didSet{
            delegate.transit(from: nil, to: currentState!)
        }
    }
    
    @discardableResult
    public func enter(state:T.State) -> Bool {
        if(!delegate.canEnter(state: state)){
            return false
        }
        delegate.transit(from: currentState, to: state)
        return true
    }
}
