//___FILEHEADER___

import SwiftUI

struct CustomShadowForeground: ViewModifier {
    
    enum Style {
        case drop, inner
    }
    
    var type: Style
    var foregroundColor: Color
    var radius: CGFloat
    var posX: CGFloat
    var posY: CGFloat
    
    func body(content: Content) -> some View {
        switch self.type {
        case .drop:
            content
                .foregroundStyle(self.foregroundColor.shadow(.drop(radius: self.radius,
                                                                   x: self.posX,
                                                                   y: self.posY)))
        case .inner:
            content
                .foregroundStyle(self.foregroundColor.shadow(.inner(radius: self.radius,
                                                                   x: self.posX,
                                                                   y: self.posY)))
        }
    }
    
}
