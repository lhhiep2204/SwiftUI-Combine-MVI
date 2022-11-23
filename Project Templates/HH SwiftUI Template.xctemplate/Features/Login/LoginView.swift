//___FILEHEADER___

import SwiftUI

struct LoginView: View {
    
    // MARK: - Enum
    enum FocusField {
        case username, password
    }
    
    // MARK: - Properties
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject private var intent = LoginViewIntent()
    @AppStorage(UserDefaultKey.isLogin.rawValue) var isLogin: Bool = false
    
    @FocusState private var focusField: FocusField?
    
    @State private var shouldShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        self.containerView
            .onReceive(self.intent.state) { state in
                self.handleState(state)
            }
            .alert(isPresented: self.$shouldShowAlert) {
                AlertView().showErrorAlert(message: self.alertMessage)
            }
    }
    
}

// MARK: - State
extension LoginView {
    
    private func handleState(_ state: LoginViewIntent.State) {
        switch state {
        case .initial:
            self.focusField = .username
            self.intent.action.send(.validation)
        case .loginSuccess:
            self.isLogin = true
            self.appRouter.state = .home
        case .error(let message):
            self.alertMessage = message
            self.shouldShowAlert = true
        }
    }
    
}

// MARK: - Views
extension LoginView {
    
    private var containerView: some View {
        ZStack {
            self.loginView
            self.loadingView
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private var loginView: some View {
        VStack(spacing: 50) {
            Spacer()
            self.titleView
            self.inputView
            self.buttonView
            Spacer()
            self.authorView
        }
    }
    
    private var titleView: some View {
        Text(StringConstant.LOGIN).font(.bold(.largeTitle)())
    }
    
    private var inputView: some View {
        VStack(spacing: 20) {
            TextField(StringConstant.USER_NAME,
                      text: self.$intent.username)
            .focused(self.$focusField, equals: .username)
            .textFieldStyle(CustomTextFieldStyle())
            .submitLabel(.next)
            .onSubmit {
                self.focusField = .password
            }
            SecureField(StringConstant.PASSWORD,
                        text: self.$intent.password)
            .focused(self.$focusField, equals: .password)
            .textFieldStyle(CustomTextFieldStyle())
            .submitLabel(.done)
        }
        .padding(EdgeInsets(top: 0,
                            leading: 50,
                            bottom: 0,
                            trailing: 50))
    }
    
    private var buttonView: some View {
        Button(StringConstant.LOGIN) {
            self.hideKeyboard()
            self.intent.action.send(.login)
        }
        .buttonStyle(CustomButtonStyle())
        .disabled(!self.intent.isValid)
    }
    
    private var authorView: some View {
        HStack {
            Spacer()
            Text("Created by: Hiep Le\nhttps://github.com/lhhiep2204/SwiftUI-Combine-MVI")
                .multilineTextAlignment(.trailing)
                .font(.system(size: 12, weight: .bold))
                .padding(.trailing, 20)
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        if self.intent.isLoading {
            LoadingView()
        } else {
            EmptyView()
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
    
}
