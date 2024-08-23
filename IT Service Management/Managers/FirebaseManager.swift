import Foundation
import FirebaseAuth
import Observation

struct AuthDataResultModel: Identifiable {
    var id: String { uid }
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

@Observable
final class FirebaseManager {
    var user: AuthDataResultModel?
    
    init() {
        guard let user = Auth.auth().currentUser else { return }
        self.user = AuthDataResultModel(user: user)
    }
    
//    func getAuthenticatedUser() throws -> AuthDataResultModel {
//        guard let user = Auth.auth().currentUser else { throw URLError(.badServerResponse) }
//        return AuthDataResultModel(user: user)
//    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        print("Creating User")
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        
        return result
    }
}
