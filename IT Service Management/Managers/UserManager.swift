import Foundation
import FirebaseFirestore

final class UserManager {
    static let shared = UserManager()
    private init() { }
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String: Any] = [
            "user_id": auth.uid,
            "date_created": Timestamp(),
        ]
        
        if let email = auth.email {
            userData["email"] = email
        }
        
        if let photoUrl = auth.photoUrl {
            userData["photoUrl"] = photoUrl
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(uid: String) async throws {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        
        guard let data = snapshot.data() else { return }
    }
}
