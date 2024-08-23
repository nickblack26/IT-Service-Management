import Foundation
import FirebaseFirestore

final class TicketManager: Listenable, Gettable {
    typealias T = Ticket
    
    static let shared = TicketManager()
    private init() { }
    
    internal let collectionReference: CollectionReference = Firestore.firestore().collection("tickets")
    
    func getAuditTrail(id: String) async throws -> [AuditTrail] {
        return try await Firestore.firestore().collection("tickets/\(id)/Audit Trail").getDocuments().documents.map { try $0.data(as: AuditTrail.self) }
    }
}

