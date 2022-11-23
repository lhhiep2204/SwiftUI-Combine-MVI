//___FILEHEADER___

import Combine
import Foundation

class HomeViewIntent: BaseIntent {
    
    // MARK: - Enums
    enum State {
        case initial
        case logoutSuccess
        case error(message: String)
    }
    
    enum Action {
        case logout
    }
    
    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let action = PassthroughSubject<Action, Never>()
    
    let topics: [Topic] = [
        Topic(title: "Device",
              name: [
                "iPhone",
                "iPad",
                "Apple Watch",
                "Macbook",
                "AirPods"
              ]),
        Topic(title: "OS",
              name: [
                "iOS",
                "iPadOS",
                "WatchOS",
                "MacOS"
              ])
    ]
    
    // MARK: - Constructors
    override init() {
        super.init()
        
        self.action
            .sink { [weak self] action in
                guard let self = self else { return }
                
                self.handleAction(action)
            }
            .store(in: &self.subscriptions)
    }
    
}

// MARK: - Action
extension HomeViewIntent {
    
    private func handleAction(_ action: Action) {
        switch action {
        case .logout:
            self.state.send(.logoutSuccess)
        }
    }
    
}
