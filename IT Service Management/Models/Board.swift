import Foundation
import FirebaseFirestore

struct Board: Identifiable, Codable {
    var id: Int
    var name: String
    var location: DocumentReference?
    var department: DocumentReference?
}
