//___FILEHEADER___

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject private var intent = HomeViewIntent()
    @AppStorage(UserDefaultKey.isLogin.rawValue) var isLogin: Bool = false
    
    var body: some View {
        self.containerView
            .onReceive(self.intent.state) { state in
                self.handleState(state)
            }
    }
    
}

// MARK: - State
extension HomeView {
    
    private func handleState(_ state: HomeViewIntent.State) {
        switch state {
        case .logoutSuccess:
            self.isLogin = false
            self.appRouter.state = .login
        default:
            break
        }
    }
    
}

// MARK: - Views
extension HomeView {
    
    private var containerView: some View {
        NavigationStack {
            self.listView
            .navigationTitle("Topics")
        }
    }
    
    private var listView: some View {
        List {
            ForEach(self.intent.topics) { topic in
                Section(topic.title) {
                    ForEach(topic.name, id: \.self) { name in
                        NavigationLink(name) {
                            DetailView(topic: name)
                        }
                    }
                }
            }
            
            Section {
                self.buttonView
            } footer: {
                self.authorView
            }
        }
    }
    
    private var buttonView: some View {
        Button("Logout") {
            self.intent.action.send(.logout)
        }
    }
    
    private var authorView: some View {
        VStack {
            Spacer()
            Text("Created by: Hiep Le - https://github.com/lhhiep2204/SwiftUI-Combine-MVI")
                .font(.system(size: 12, weight: .bold))
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
    
}
