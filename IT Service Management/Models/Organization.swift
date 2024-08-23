import Foundation
import FirebaseFirestore

struct Organization: Identifiable, Codable {
    var id: UUID = .init()
    var company: DocumentReference
}
