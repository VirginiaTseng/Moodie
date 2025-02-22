struct AddEmergencyContactView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var relationship = ""
    @State private var shareLocation = true
    @State private var shareTrip = true
    
    var body: some View {
        NavigationView {
            Form {
                Section("Contact Information") {
                    TextField("Name", text: $name)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Relationship", text: $relationship)
                }
                
                Section("Sharing Settings") {
                    Toggle("Share Location", isOn: $shareLocation)
                    Toggle("Share Trip", isOn: $shareTrip)
                }
            }
            .navigationTitle("Add Emergency Contact")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") { saveContact() }
            )
        }
    }
    
    private func saveContact() {
        let contact = EmergencyContact(
            name: name,
            phoneNumber: phoneNumber,
            relationship: relationship,
            shareLocation: shareLocation,
            shareTrip: shareTrip
        )
        modelContext.insert(contact)
        dismiss()
    }
} 