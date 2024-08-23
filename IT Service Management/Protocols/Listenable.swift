import Foundation
import FirebaseFirestore

protocol Listenable {
    associatedtype T: Codable
    var collectionReference: CollectionReference { get }
    mutating func addListenerForAllDocuments(completion: @escaping (_ items: [T]) -> Void)
}

extension Listenable {
    mutating func addListenerForAllDocuments(completion: @escaping (_ items: [T]) -> Void) {
        collectionReference.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return }
                        
            let items: [T] = documents.compactMap({ try? $0.data(as: T.self) })
            
            completion(items)
        }
    }
}
