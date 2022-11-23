//___FILEHEADER___

import SwiftUI

struct CustomShadow: ViewModifier {
    
    var shadowRadius: CGFloat
    var shadowColor: Color
    var posX: CGFloat
    var posY: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: self.shadowColor, radius: self.shadowRadius, x: self.posX, y: self.posY)
    }
    
}
