//
//  BoardManager.swift
//  IT Service Management
//
//  Created by Nick Black on 8/21/24.
//

import Foundation
import FirebaseFirestore

final class BoardManager {
    static let shared = BoardManager()
    private init() { }
    
    private let boardCollection: CollectionReference = Firestore.firestore().collection("boards")
    
    func addListenerForAllBoards(completion: @escaping (_ boards: [Board]) -> Void) {
        boardCollection.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { documnet in
                do {
                    print(try documnet.data(as: Board.self))
                } catch {
                    print(error)
                }
            }
            
            let boards: [Board] = documents.compactMap({ try? $0.data(as: Board.self) })
            
            completion(boards)
        }
    }
}
