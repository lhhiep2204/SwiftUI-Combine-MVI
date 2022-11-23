//___FILEHEADER___

import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    
    // MARK: - Properties
    @ObservedObject private var intent = ___FILEBASENAMEASIDENTIFIER___Intent()
    @EnvironmentObject private var appRouter: AppRouter
    
    var body: some View {
        self.containerView
            .onReceive(self.intent.state) { state in
                self.handleState(state)
            }
    }
    
}

// MARK: - State
extension ___FILEBASENAMEASIDENTIFIER___ {
    
    private func handleState(_ state: ___FILEBASENAMEASIDENTIFIER___Intent.State) {
        print("___FILEBASENAMEASIDENTIFIER___ state: \(state)")
    }
    
}

// MARK: - Views
extension ___FILEBASENAMEASIDENTIFIER___ {
    
    private var containerView: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
}

struct ___FILEBASENAMEASIDENTIFIER____Previews: PreviewProvider {
    
    static var previews: some View {
        ___FILEBASENAMEASIDENTIFIER___()
    }
    
}
