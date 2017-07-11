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

/// Protocol default Impl
extension StateMachineDelegate{
    func canEnter(state:State) -> Bool{
        return true
    }
}

// MARK: Impl
struct StateHandler<T>:StateMachineDelegate {
    typealias State = T
    
    func transit(from: T?, to: T) {
        
    }
}

// MARK: StateMachine
public class StateMachine<Handler:StateMachineDelegate> {
    
    public let stateHandler:Handler
    
    public init(stateHandler:Handler) {
        self.stateHandler = stateHandler
    }
    
    public var currentState:Handler.State?{
        didSet{
            stateHandler.transit(from: nil, to: currentState!)
        }
    }
    
    @discardableResult
    public func enter(state:Handler.State) -> Bool {
        if(!stateHandler.canEnter(state: state)){
            return false
        }
        stateHandler.transit(from: currentState, to: state)
        return true
    }
}
