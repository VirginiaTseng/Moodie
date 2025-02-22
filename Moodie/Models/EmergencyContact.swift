import SwiftUI
import SwiftData

@Model
class EmergencyContact {
    var name: String
    var phoneNumber: String
    var relationship: String
    var isEmergencyNumber: Bool // For emergency service numbers
    var shareLocation: Bool // Allow location sharing
    var shareTrip: Bool // Allow trip sharing
    
    init(name: String, phoneNumber: String, relationship: String, 
         isEmergencyNumber: Bool = false, shareLocation: Bool = true, shareTrip: Bool = true) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.relationship = relationship
        self.isEmergencyNumber = isEmergencyNumber
        self.shareLocation = shareLocation
        self.shareTrip = shareTrip
    }
} 