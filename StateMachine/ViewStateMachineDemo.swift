//
//  ViewStateMachineDemo.swift
//  StateMachine
//
//  Created by iShawnWang on 2017/7/10.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import UIKit

class ViewStateMachineDemo: UIViewController {
    
    let uiStateDelegate = DefaultViewStateMachineDelegate()
    lazy var uiState:ViewStateMachine<DefaultViewStateMachineDelegate> = {
        let m = ViewStateMachine(superView: self.view, delegate: self.uiStateDelegate)
        return m
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            
            let failedView = StateView.loadFromXib()
            failedView.label.text = "failed"
            self.uiState.enter(state:ViewState(failed:failedView))
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
                
                let noDataView = StateView.loadFromXib()
                noDataView.label.text = "noData"
                self.uiState.enter(state: ViewState(noData:noDataView))
                
            }
        }
    }
}



