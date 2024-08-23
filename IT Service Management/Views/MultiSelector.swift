import SwiftUI

struct MultiSelector<Item: Hashable & Identifiable>: View {
    var items: [Item]
    @Binding var selectedItems: Set<Item.ID>
    
    var body: some View {
        List {
            ForEach(items) { item in
                var isChecked = selectedItems.contains(item.id)
                HStack {
                    Text("\(item.id)")
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .opacity(isChecked ? 1.0 : 0)
                }
                .onTapGesture {
                    print(isChecked)
                    if isChecked {
                        selectedItems.remove(item.id)
                        print("removing \(item.id)")
                    } else {
                        selectedItems.insert(item.id)
                        print("tapping \(item.id)")
                    }
                }
                .background(isChecked ? Color.accentColor.opacity(0.5) : .clear)
            }
        }
    }
}

#Preview {
    @State var isShowing: Bool = true
    @State var selectedTickets: Set<Ticket.ID> = .init()
    @State var tickets: [Ticket] = [
        .init(id: 1, summary: "", recordType: .projectTicket, dateEntered: .init()),
        .init(id: 2, summary: "", recordType: .projectTicket, dateEntered: .init())
    ]
    return VStack {
        Button("Show") {
            isShowing.toggle()
        }
        .popover(isPresented: $isShowing) {
            MultiSelector(items: tickets, selectedItems: $selectedTickets)
        }
    }
    .frame(minWidth: 500, minHeight: 500)
}
