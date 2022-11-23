//___FILEHEADER___

import Combine

enum AppState {
    case launchScreen, login, home
}

class AppRouter: ObservableObject {
    
    @Published var state: AppState = .launchScreen
    
}
