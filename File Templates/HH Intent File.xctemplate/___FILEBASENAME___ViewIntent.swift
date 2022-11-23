//___FILEHEADER___

import Combine
import Foundation

class ___FILEBASENAMEASIDENTIFIER___: BaseIntent {
    
    // MARK: - Enums
    enum State {
        case initial
        case error(message: String)
    }
    
    enum Action {
        case actionX
    }
    
    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let action = PassthroughSubject<Action, Never>()
    
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
extension ___FILEBASENAMEASIDENTIFIER___ {
    
    private func handleAction(_ action: Action) {
        switch action {
        case .actionX:
            print("___FILEBASENAMEASIDENTIFIER___ action - actionX")
        }
    }
    
}
