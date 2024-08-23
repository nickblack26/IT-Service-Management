import Foundation
import FirebaseFirestore

struct Configuration: Identifiable, Codable {
    var id: Int
    var name: String
    var contact: DocumentReference
}
