//___FILEHEADER___

import Combine

class BaseIntent: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    
}
