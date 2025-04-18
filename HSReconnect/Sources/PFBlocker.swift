import Foundation
import Combine

class PFBlocker: ObservableObject {
    @Published var isBlocked: Bool = false
    private let pfAnchor = "com.HSReconnect.firewall"
    private let pfRulesPath = Bundle.main.path(forResource: "hs_block", ofType: "pf")!

    /// Toggle blocking state: true = block (pause), false = unblock (resume)
    func toggle() {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if !self.isBlocked {
                    try runPfctl(args: ["-E"])
                    try runPfctl(args: ["-a", self.pfAnchor, "-f", self.pfRulesPath])
                    try runPfctl(args: ["-k", "0.0.0.0", "-k", "1119"])
                    try runPfctl(args: ["-k", "0.0.0.0", "-k", "3724"])
                } else {
                    try runPfctl(args: ["-a", self.pfAnchor, "-F", "all"])
                }
                DispatchQueue.main.async {
                    self.isBlocked.toggle()
                }
            } catch {
                print("PF Error: \(error.localizedDescription)")
            }
        }
    }
}
