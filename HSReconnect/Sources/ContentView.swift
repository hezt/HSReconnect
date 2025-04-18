import SwiftUI

struct ContentView: View {
    @EnvironmentObject var blocker: PFBlocker
    @Binding var isBlocked: Bool

    var body: some View {
        VStack(spacing: 12) {
            Text(isBlocked ? "Disconnected" : "Connected")
                .font(.title2)

            Button(action: { blocker.toggle() }) {
                Text(isBlocked ? "Resume" : "Pause")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
