//___FILEHEADER___

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject private var appRouter: AppRouter
    @AppStorage(UserDefaultKey.isLogin.rawValue) var isLoggedIn: Bool = false
    
    var body: some View {
        Text("HH SwiftUI Template")
            .font(.bold(.title)())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.appRouter.state = self.isLoggedIn ? .home : .login
                }
            }
    }
    
}

struct LaunchScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        LaunchScreenView()
    }
    
}
