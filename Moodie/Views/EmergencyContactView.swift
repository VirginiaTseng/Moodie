import SwiftUI
import SwiftData

struct EmergencyContactView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var contacts: [EmergencyContact]
    @StateObject private var locationManager = LocationManager()
    
    @State private var showingAddContact = false
    @State private var longPressedContact: EmergencyContact?
    @State private var showingActionSheet = false
    
    var body: some View {
        NavigationView {
            List {
                // Emergency Services Section
                Section("Emergency Services") {
                    EmergencyServiceRow(
                        icon: "ambulance.fill",
                        title: "Ambulance",
                        number: "911"
                    )
                    EmergencyServiceRow(
                        icon: "shield.fill",
                        title: "Police",
                        number: "911"
                    )
                    EmergencyServiceRow(
                        icon: "flame.fill",
                        title: "Fire",
                        number: "911"
                    )
                }
                
                // Emergency Contacts Section
                Section("Emergency Contacts") {
                    ForEach(contacts) { contact in
                        EmergencyContactRow(contact: contact)
                            .onLongPressGesture {
                                longPressedContact = contact
                                showingActionSheet = true
                            }
                    }
                    .onDelete(perform: deleteContacts)
                }
            }
            .navigationTitle("Emergency Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddContact = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddContact) {
                AddEmergencyContactView()
            }
            .actionSheet(isPresented: $showingActionSheet) {
                emergencyActionSheet
            }
        }
    }
    
    private var emergencyActionSheet: ActionSheet {
        guard let contact = longPressedContact else {
            return ActionSheet(title: Text("Error"))
        }
        
        return ActionSheet(
            title: Text(contact.name),
            message: Text("Choose Emergency Action"),
            buttons: [
                .default(Text("Call")) {
                    EmergencyService.shared.callEmergencyContact(contact.phoneNumber)
                },
                .default(Text("Share Location")) {
                    EmergencyService.shared.sendEmergencyMessage(
                        to: contact,
                        location: locationManager.location
                    )
                },
                .default(Text("Share Trip")) {
                    EmergencyService.shared.sendEmergencyMessage(
                        to: contact,
                        location: locationManager.location,
                        tripInfo: "Trip from Origin to Destination"
                    )
                },
                .cancel(Text("Cancel"))
            ]
        )
    }
    
    private func deleteContacts(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(contacts[index])
        }
    }
}

// Emergency Service Row View
struct EmergencyServiceRow: View {
    let icon: String
    let title: String
    let number: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.red)
            Text(title)
            Spacer()
            Text(number)
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            EmergencyService.shared.callEmergencyContact(number)
        }
    }
}

// Emergency Contact Row View
struct EmergencyContactRow: View {
    let contact: EmergencyContact
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.name)
                .font(.headline)
            Text(contact.relationship)
                .font(.subheadline)
                .foregroundColor(.gray)
            if contact.shareLocation || contact.shareTrip {
                HStack {
                    if contact.shareLocation {
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                    }
                    if contact.shareTrip {
                        Image(systemName: "figure.walk")
                            .foregroundColor(.green)
                    }
                }
                .font(.caption)
            }
        }
    }
} 