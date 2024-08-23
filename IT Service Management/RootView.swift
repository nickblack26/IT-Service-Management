import SwiftUI

struct RootView: View {
    @Environment(AuthenticationManager.self) private var authManager
    @State private var isPresented: Bool = false
    @State private var selectedTab: Tab = .dashboard
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedTab) {
                ForEach(Tab.allCases, id: \.self) {
                    Text($0.rawValue.capitalized)
                }
            }
        } detail: {
            NavigationStack {
                ZStack {
                    switch selectedTab {
                    case .dashboard:
                        EmptyView()
                    case .inbox:
                        EmptyView()
                    case .notifications:
                        EmptyView()
                    case .tickets:
                        TicketListView()
                    case .knowledgeBase:
                        EmptyView()
                    case .customers:
                        EmptyView()
                    case .contacts:
                        EmptyView()
                    }
                }
                .navigationDestination(for: Ticket.self) { ticket in
                    Text(ticket.summary)
                }
            }
        }
        .onAppear {
            do {
                let _ = try authManager.getAuthenticatedUser()
                self.isPresented = authManager.user == nil
            } catch {
                print(error)
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                LoginView(isPresented: $isPresented)
            }
        }
        .toolbar {
            ToolbarItem {
                Menu("User", systemImage: "person") {
                    Button("Sign out") {
                        do {
                            try authManager.signOut()
                            self.isPresented = true
                        } catch {
                            print("Couldn't Sign Out")
                        }
                    }
                }
            }
        }
        .frame(
            minWidth: 500,
            minHeight: 500
        )
    }
}

enum Tab: String, CaseIterable {
    case dashboard, inbox, notifications, tickets
    case knowledgeBase = "Knowledge Base"
    case customers, contacts
}

#Preview {
    @State var firebase = AuthenticationManager()
    return NavigationStack {
        RootView()
    }
    .frame(minWidth: 500, minHeight: 500)
    .environment(firebase)
}
