//___FILEHEADER___

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background((configuration.isPressed || !self.isEnabled) ? .gray : self.colorScheme == .dark ? .white : .black)
            .foregroundColor(self.colorScheme == .dark ? .black : .white)
            .frame(height: 40)
            .clipShape(Capsule())
    }
    
}
