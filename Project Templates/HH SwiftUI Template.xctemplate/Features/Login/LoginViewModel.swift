//___FILEHEADER___

import Combine
import Foundation

class LoginViewModel: BaseViewModel {
    
    // MARK: - Enums
    enum State {
        case initial
        case loginSuccess
        case error(message: String)
    }
    
    enum Action {
        case login
    }
    
    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let action = PassthroughSubject<Action, Never>()
    
    @Published var email: String? = ""
    @Published var password: String? = ""
    
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
extension LoginViewModel {
    
    private func handleAction(_ action: Action) {
        switch action {
        case .login:
            self.handleLogin()
        }
    }
    
}

// MARK: - Methods
extension LoginViewModel {
    
    private func handleLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if (self.email ?? "").count % 2 == 0 {
                self.state.send(.loginSuccess)
            } else {
                self.state.send(.error(message: "Try again"))
            }
        }
    }
    
}

// MARK: - Validation
extension LoginViewModel {
    
    var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(self.validateEmail, self.validatePassword)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
    
    var validateEmail: AnyPublisher<Bool, Never> {
        return self.$email
            .map { CommonManager.validate(input: $0 ?? "", pattern: .email) }
            .eraseToAnyPublisher()
    }
    
    var validatePassword: AnyPublisher<Bool, Never> {
        return self.$password
            .map { !($0 ?? "").isEmpty }
            .eraseToAnyPublisher()
    }
    
}
