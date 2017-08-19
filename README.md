# StateMachine

[![Swift Version][swift-image]][swift-url] [![Build Status][travis-image]][travis-url] [![License][license-image]][license-url] [![codebeat-badge][codebeat-image]][codebeat-url]

> A simple State Machine to organize your ViewController

# Why use StateMachine
**This demonstrate the cycle of a basic ViewController**

![](https://ws1.sinaimg.cn/large/006tKfTcly1fiox4orkz9j30kd0avgmo.jpg)


I want to show different view to notify user the current state of the App

- refreshing : show ActityIndocator
- error : show error image and a `retry` button
- list: show the data that retrived from the network
    
#### And this works perfect with [FSM (Finite-state machine)](https://en.wikipedia.org/wiki/Finite-state_machine)

# Usage

There 2 main class, [ViewStateMachine](https://github.com/iShawnWang/StateMachine/blob/master/StateMachine/StateMachine/ViewStateMachine/ViewStateMachine.swift) and [StateMachine](https://github.com/iShawnWang/StateMachine/blob/master/StateMachine/StateMachine/StateMachine.swift)
1. `StateMachine` is a generic FSM
2. `ViewStateMachine` is build on `StateMachine` for switching views when enter different state

**Check demo code for example**

## **ViewStateMachine** 
Check [ViewStateMachineDemo.swift](https://github.com/iShawnWang/StateMachine/blob/master/StateMachine/ViewStateMachineDemo.swift) for example

#####  1. In your ViewController create `ViewStateMachine` and `DefaultViewStateMachineDelegate`
`DefaultViewStateMachineDelegate` demonstrate switch view when state changed

```swift
    let uiStateDelegate = DefaultViewStateMachineDelegate()
    lazy var uiState:ViewStateMachine<DefaultViewStateMachineDelegate> = {
        let m = ViewStateMachine(superView: self.view, delegate: self.uiStateDelegate)
        return m
    }()
```

##### 2. Change State with view
```swift
    let failedView = StateView.loadFromXib()
    failedView.label.text = "failed"
    self.uiState.enter(state:ViewState(failed:failedView))
```

## **StateMachine**

Check [StateMachineDemo.swift](https://github.com/iShawnWang/StateMachine/blob/master/StateMachine/StateMachineDemo.swift) for example
##### 0. Create you state 

```swift
    enum DemoState {
        case error
        case success
    }
```

##### 1. Create a `StateMachine` instance

```swift
    class StateMachineDemo: UIViewController {
    
        lazy var stateMachine:StateMachine<StateMachineDemo> = {
            let sm = StateMachine(delegate: self)
            return sm
        }()
    }
```

##### 2. Implement StateMachineDelegate

```swift
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
```

##### 3. Change the state

```swift
    self.stateMachine.enter(state: .success)
```

# Thanks
This project is for studying, you'd prefer using libs below : 
> [aschuch/StatefulViewController](https://github.com/aschuch/StatefulViewController)
> [narfdotpl/SwiftyStateMachine](https://github.com/narfdotpl/SwiftyStateMachine)

# Contact

- weibo : [@王大屁帅2333](http://weibo.com/p/1005052848310723/home?from=page_100505&mod=TAB&is_all=1#place)  
- email : iShawnwang2333@gmail.com

> It seems that my README is a bit longer than the code i write :D

# License
Distributed under the GPL v3 license. See [LICENSE](https://github.com/iShawnWang/StateMachine/blob/master/LICENSE) for more information.


[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/license-GPL%20V3-red.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg
[travis-url]: https://travis-ci.org/iShawnWang/StateMachine.svg?branch=master
[codebeat-image]: https://codebeat.co/badges/baf1c681-7826-4e8a-b647-1df5f37e44b0
[codebeat-url]: https://codebeat.co/projects/github-com-ishawnwang-statemachine-master/


