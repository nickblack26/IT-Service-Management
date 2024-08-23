import SwiftUI
import FirebaseFirestore

struct BoardsView: View {
    @State private var boards: [Board] = []
    @State private var didAppear: Bool = false
    
    var body: some View {
        List {
            ForEach(boards) { board in
                Text("\(board.id)")
                Text(board.name)
            }
        }
        .onAppear {
            if !didAppear {
                addListenerForBoards()
                didAppear = true
            }
        }
    }
    
    func addListenerForBoards() {
        BoardManager.shared.addListenerForAllBoards { boards in
            print(boards)
            self.boards = boards
        }
    }
}

#Preview {
    BoardsView()
}
