import Foundation

struct Contact: Identifiable, Codable, Hashable {
    var id: Int
    var firstName: String
    var lastName: String
}
