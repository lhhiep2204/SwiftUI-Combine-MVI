//___FILEHEADER___

import SwiftUI

struct DetailView: View {
    
    // MARK: - Properties
    @ObservedObject private var intent = DetailViewIntent()
    @EnvironmentObject private var appRouter: AppRouter
    
    let topic: String
    
    var body: some View {
        self.containerView
            .onReceive(self.intent.state) { state in
                self.handleState(state)
            }
    }
    
}

// MARK: - State
extension DetailView {
    
    private func handleState(_ state: DetailViewIntent.State) {
        switch state {
        case .initial:
            self.intent.action.send(.getNews(topic: self.topic))
        case .getNewsSuccess:
            print(self.intent.articles)
        case .error(let message):
            print("Error \(message)")
        }
    }
    
}

// MARK: - Views
extension DetailView {
    
    private var containerView: some View {
        self.listView
        .navigationTitle(self.topic)
    }
    
    private var listView: some View {
        List(self.intent.articles, id: \.self) { article in
            DetailItem(article: article)
        }
        .refreshable {
            self.intent.action.send(.getNews(topic: self.topic))
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(topic: "iOS")
    }
    
}
