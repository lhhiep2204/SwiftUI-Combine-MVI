//___FILEHEADER___

import Combine
import Foundation

class LoginViewIntent: BaseIntent {
    
    // MARK: - Enums
    enum State {
        case initial
        case loginSuccess
        case error(message: String)
    }
    
    enum Action {
        case validation
        case login
    }
    
    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let action = PassthroughSubject<Action, Never>()
    
    @Published var username = ""
    @Published var password = ""
    @Published var isValid = false
    @Published var isLoading = false
    
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
extension LoginViewIntent {
    
    private func handleAction(_ action: Action) {
        switch action {
        case .validation:
            self.validatedCredentials
                .assign(to: &self.$isValid)
        case .login:
            self.isLoading = true
            self.login()
        }
    }
    
}

// MARK: - Validation
extension LoginViewIntent {
    
    private var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(self.validateUsername, self.validatePassword)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
    
    private var validateUsername: AnyPublisher<Bool, Never> {
        return self.$username
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var validatePassword: AnyPublisher<Bool, Never> {
        return self.$password
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Methods
extension LoginViewIntent {
    
    private func login() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            if self.username.count > 3 {
                self.state.send(.loginSuccess)
            } else {
                self.state.send(.error(message: "Try again"))
            }
        }
    }
    
}
