import SwiftUI

struct ItemRow: View {
    var title: String
    
    @Environment(\.isFocused) var isFocused: Bool
    
    var body: some View {
        Text(title)
            .foregroundColor(isFocused ? .red : .white)
    }
}
