import Foundation
import FirebaseFirestore

protocol Gettable {
    associatedtype T: Codable
    var collectionReference: CollectionReference { get }
    
    func getDocument(id: String) async throws -> T
    func deleteDocument(id: String)
    func getDocuments() async throws -> [T]
}

extension Gettable {
    func getDocument(id: String) async throws -> T {
        let document = try await collectionReference.document(id).getDocument()
        guard document.exists else { throw URLError(.unknown) }
        
        return try document.data(as: T.self)
    }
    
    func deleteDocument(id: String) { collectionReference.document(id).delete() }
    
    func getDocuments() async throws -> [T] {
        return try await collectionReference.getDocuments().documents.map {try $0.data(as: T.self) }
    }
}

