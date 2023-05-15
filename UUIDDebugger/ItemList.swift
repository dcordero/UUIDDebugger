import SwiftUI

struct ItemList: View {
    @State private var logs: [LogItem] = []
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(logs) { log in
                    ZStack {
                        ItemRow(title: "\(log.date) - \(log.event) - [\(log.deviceUUID)]")
                            .padding()
                    }
                    .focusable()
                }
            }
        }
        .onAppear {
            fetchLogs()
        }
        .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
            fetchLogs()
        }
    }
    
    private func fetchLogs() {
        if let savedLogs = UserDefaults.standard.array(forKey: "LifeCycleLogs") as? [[String: Any]] {
            logs = savedLogs.compactMap { logDict in
                guard let date = logDict["date"] as? Date,
                      let event = logDict["name"] as? String,
                      let deviceUUID = logDict["deviceUUID"] as? String else {
                    return nil
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss"
                let dateString = dateFormatter.string(from: date)
                
                return LogItem(date: dateString, event: event, deviceUUID: deviceUUID)
            }
        }
    }
}

struct LogItem: Identifiable {
    let id = UUID()
    let date: String
    let event: String
    let deviceUUID: String
}
