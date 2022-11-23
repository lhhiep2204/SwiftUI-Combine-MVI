//___FILEHEADER___

import SwiftUI

struct AlertView {
    
    func showErrorAlert(title: String = StringConstant.ERROR,
                        message: String) -> Alert {
        Alert(title: Text(title),
              message: Text(message),
              dismissButton: .cancel(Text(StringConstant.OK)))
    }
    
}

extension AlertView {
    
    enum PermissionType: String {
        case photo = "Photo permission denied. Open settings to allow permission"
        case bluetooth = "Bluetooth permission denied. Open settings to allow permission"
        case contact = "Contact permission denied. Open settings to allow permission"
        case location = "Location permission denied. Open settings to allow permission"
    }
    
    func showPermissionDeniedAlert(title: String = StringConstant.PERMISSION_DENIED,
                                   permissionType: PermissionType) -> Alert {
        Alert(title: Text(title),
              message: Text(permissionType.rawValue),
              primaryButton: .default(Text(StringConstant.SETTINGS),
                                      action: {
            CommonManager.openApplicationSettings()
        }),
              secondaryButton: .cancel(Text(StringConstant.CLOSE)))
    }
    
}
