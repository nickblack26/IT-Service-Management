import Foundation
import FirebaseFirestore

struct Board: Codable, Identifiable {
    var id: Int
    var name: String
    var location: DocumentReference?
    var department: DocumentReference?
}
