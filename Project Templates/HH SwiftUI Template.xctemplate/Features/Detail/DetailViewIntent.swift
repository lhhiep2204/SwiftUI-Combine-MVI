//___FILEHEADER___

import Combine
import Foundation

class DetailViewIntent: BaseIntent {
    
    // MARK: - Enums
    enum State {
        case initial
        case getNewsSuccess
        case error(message: String)
    }
    
    enum Action {
        case getNews(topic: String)
    }
    
    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let action = PassthroughSubject<Action, Never>()
    
    private let service = NewsService()
    
    @Published var articles = [Article]()
    
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
extension DetailViewIntent {
    
    private func handleAction(_ action: Action) {
        switch action {
        case .getNews(let topic):
            self.getNews(topic)
        }
    }
    
}

// MARK: - Methods
extension DetailViewIntent {
    
    private func getNews(_ topic: String) {
        self.service.getNews(topic: topic)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                if case .failure(let error) = completion {
                    self.state.send(.error(message: error.message))
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.articles = value.articles ?? []
                self.state.send(.getNewsSuccess)
            }
            .store(in: &self.subscriptions)
    }
    
}
