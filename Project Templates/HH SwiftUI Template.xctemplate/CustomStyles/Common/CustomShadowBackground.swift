//___FILEHEADER___

import SwiftUI

struct CustomShadowBackground: ViewModifier {
    
    enum Style {
        case drop, inner
    }
    
    var type: Style
    var backgroundColor: Color
    var radius: CGFloat
    var posX: CGFloat
    var posY: CGFloat
    
    func body(content: Content) -> some View {
        switch self.type {
        case .drop:
            content
                .backgroundStyle(self.backgroundColor.shadow(.drop(radius: self.radius,
                                                                   x: self.posX,
                                                                   y: self.posY)))
        case .inner:
            content
                .backgroundStyle(self.backgroundColor.shadow(.inner(radius: self.radius,
                                                                   x: self.posX,
                                                                   y: self.posY)))
        }
    }
    
}
