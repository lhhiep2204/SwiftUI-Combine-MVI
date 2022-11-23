//___FILEHEADER___

import SwiftUI

struct CustomBorder: ViewModifier {
    
    var cornerRadius: CGFloat
    var borderColor: Color
    var lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(self.cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .stroke(self.borderColor, lineWidth: self.lineWidth)
            }
    }
    
}
