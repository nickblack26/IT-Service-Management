//
//  LoginView.swift
//  IT Service Management
//
//  Created by Nick Black on 8/21/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(AuthenticationManager.self) private var authManager
    @Binding var isPresented: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        Form {
            TextField(
                "Email",
                text: $email,
                prompt: Text("Email...")
            )
            .textFieldStyle(.roundedBorder)
            
            TextField(
                "Password",
                text: $password,
                prompt: Text(
                    "Password..."
                )
            )
            .textFieldStyle(.roundedBorder)
            
            Button("Sign In") {
                signIn()
            }
            
            Button("Sign Up") {
                signUp()
            }
        }
        .frame(minWidth: 250, minHeight: 250)
        .padding()
        .onSubmit {
            signIn()
        }
        .labelsHidden()
        .navigationTitle("Sign In")
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {return}
        
        Task {
            do {
                let returnedUser = try await authManager.signInUser(
                    email: email,
                    password: password
                )
                print("Success")
                print(returnedUser)
                self.isPresented = false
            } catch {
                print("Error: \(error)")
            }
        }
    } 
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {return}
        
        Task {
            do {
                let returnedUser = try await authManager.createUser(
                    email: email,
                    password: password
                )
                print("Success")
                print(returnedUser)
                self.isPresented = false
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

#Preview {
    @State var authManager = AuthenticationManager()
    return NavigationStack {
        LoginView(isPresented: .constant(true))
    
    }
    .environment(authManager)
}
