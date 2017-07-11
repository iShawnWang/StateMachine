//
//  ViewController.swift
//  StateMachine
//
//  Created by iShawnWang on 2017/7/10.
//  Copyright © 2017年 iShawnWang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var uiState:ViewStateMachine = {
        let machine = ViewStateMachine(superView: self.view, stateHandler: ViewStateHandler())
        return machine
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

