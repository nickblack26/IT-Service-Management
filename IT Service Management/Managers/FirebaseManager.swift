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
final class AuthenticationManager {
    var user: AuthDataResultModel?
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else { throw URLError(.badServerResponse) }
        let authUser = AuthDataResultModel(user: user)
        self.user = authUser
        return authUser
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        print("Creating User")
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        self.user = result
        try await UserManager.shared.createNewUser(auth: result)
        
        return result
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        print("Signing In User")
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        self.user = result
        
        return result
    }
    
    func resetPassword(email: String) async throws {
        print("Signing In User")
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }    
    
    func updatePassword(password: String) async throws {
        try await Auth.auth().currentUser?.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        try await Auth.auth().currentUser?.updateEmail(to: email)
    }
    
    func signOut() throws {
        print("Signing Out User")
        try Auth.auth().signOut()
        self.user = nil
    }
}
