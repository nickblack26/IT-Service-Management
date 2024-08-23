import Foundation

struct Company: Identifiable, Codable {
    var id: Int
    var identifier: String
    var name: String
    var phoneNumbers: [String]?
}
