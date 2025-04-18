import SwiftUI

@main
struct HSReconnectApp: App {
    @StateObject private var blocker = PFBlocker()

    var body: some Scene {
        WindowGroup {
            ContentView(isBlocked: $blocker.isBlocked)
                .frame(width: 240, height: 120)
                .environmentObject(blocker)
        }
    }
}
