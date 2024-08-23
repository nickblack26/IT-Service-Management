import SwiftUI

struct TicketListView: View {
    @State private var tickets: [Ticket] = []
    @State private var selectedItem: Set<Ticket.ID>?
    @State private var navPath = NavigationPath()
    @State private var selectedTypes: Set<Ticket.RecordType> = .init()
    
    var body: some View {
        VStack {
            HStack {
                Picker("Type", selection: $selectedTypes) {
                    ForEach(Ticket.RecordType.allCases, id: \.self) { recordType in
                        Text(recordType.rawValue)
                            .tag(recordType)
                    }
                }
            }
            
            var filteredTickets: [Ticket] {
                if selectedTypes.isEmpty {
                    return tickets
                } else {
                    return tickets.filter { ticket in
                        return selectedTypes.contains(ticket.recordType)
                    }
                }
            }
            
            Table(filteredTickets) {
                TableColumn("") { ticket in
                    Toggle("Select", isOn: .init(get: {
                        selectedItem?.contains(ticket.id) ?? false
                    }, set: { isSelected in
                        if isSelected {
                            selectedItem?.insert(ticket.id)
                        } else {
                            selectedItem?.remove(ticket.id)
                        }
                    }))
                    .toggleStyle(.checkbox)
                }
                .width(32)
                
                TableColumn("Ticket ID") {
                    Text(verbatim: "#\($0.id)")
                }
                .width(64)
                
                TableColumn("Summary", value: \.summary)
                    .width(min: 160, ideal: 320, max: 480)
                
                TableColumn("Type", value: \.recordType.rawValue)
                
                TableColumn("Date Entered") {
                    Text(
                        $0.dateEntered.dateValue(),
                        format: .relative(presentation: .numeric)
                    )
                }
            }
        }
        .onChange(of: selectedItem, { oldValue, newValue in
            guard let newValue else {return}
            
            if !newValue.isEmpty {
                
            }
        })
        .task {
            do {
                self.tickets = try await TicketManager.shared.getDocuments()
            } catch {
                self.tickets = []
            }
        }
    }
}

#Preview {
    TicketListView()
}
