import Foundation
import FirebaseFirestore

struct Ticket: Identifiable, Codable, Hashable {
    var id: Int
    var summary: String
    var recordType: RecordType
    var board: DocumentReference?
    var dateEntered: Timestamp
}

extension Ticket {
    enum RecordType: String, Codable, CaseIterable {
        case projectIssue = "ProjectIssue"
        case projectTicket = "ProjectTicket"
        case serviceTicket = "ServiceTicket"
    }
}
