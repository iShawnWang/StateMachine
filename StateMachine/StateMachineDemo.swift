//
//  StateMachineDemo.swift
//  StateMachine
//
//  Created by iShawnWang on 2017/8/19.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import Foundation
import UIKit


enum DemoState {
    case error
    case success
}

class StateMachineDemo: UIViewController {
    
    lazy var stateMachine:StateMachine<StateMachineDemo> = {
        let sm = StateMachine(delegate: self)
        return sm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stateMachine.enter(state: .error)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) { 
            self.stateMachine.enter(state: .success)
        }
    }
}

extension StateMachineDemo: StateMachineDelegate {
    typealias State = DemoState
    
    func canEnter(state: DemoState) -> Bool {
        return true
    }
    
    func transit(from: DemoState?, to: DemoState) {
        switch to {
        case .error:
            print("error")
        case .success:
            print("success")
        }
    }
}
