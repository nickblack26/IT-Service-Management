import SwiftUI
import AppKit
import FirebaseCore
import FirebaseFirestore

@main
struct IT_Service_ManagementApp: App {
    @State private var authManager = AuthenticationManager()
    
    init() {
        FirebaseApp.configure()
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = false
                
        let firestore = Firestore.firestore()
        firestore.settings = settings
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(authManager)
        }
    }
}
