//
//  FirebaseManager.swift
//  Moodie
//
//  Created by Virginia Zheng on 2025-02-25.
//
import SwiftUI


class FirebaseService: ObservableObject {
    static let shared = FirebaseService()
//    private let db = Firestore.firestore()
//   private let storage = Storage.storage().reference()
//
//    @Published var incidents: [Incident] = []
//    
//    func submitIncident(_ incident: Incident, image: UIImage?) async throws {
//        var imageURL: String?
//        
//        if let image = image {
//            imageURL = try await uploadImage(image)
//        }
//        
//        let data: [String: Any] = [
//            "type": incident.type.rawValue,
//            "description": incident.description,
//            "latitude": incident.latitude,
//            "longitude": incident.longitude,
//            "timestamp": FieldValue.serverTimestamp(),
//            "imageURL": imageURL,
//            "status": "ACTIVE"
//        ]
//        
//        try await db.collection("incidents").addDocument(data: data)
//    }
//    
    private func uploadImage(_ image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else {
            throw URLError(.badURL)
        }
        
        let filename = "\(UUID().uuidString).jpg"
//        let ref = storage.child("incidents/\(filename)")
//        
//        _ = try await ref.putDataAsync(imageData)
//        let url = try await ref.downloadURL()
//        return url.absoluteString
        
         return ""
    }
}
