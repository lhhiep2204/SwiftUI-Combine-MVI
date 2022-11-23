//___FILEHEADER___

import Foundation

extension String {
    
    var trim: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}

extension String {
    
    func toDate(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
    
}
