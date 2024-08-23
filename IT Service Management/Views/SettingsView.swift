import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Button("Log out") {
                
            }
            
            Section("Email Functions") {
                Button("Log out") {
                    
                }
                
                Button("Reset password") {
                    
                }
                
                Button("Update password") {
                    
                }
                
                Button("Update email") {
                    
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
