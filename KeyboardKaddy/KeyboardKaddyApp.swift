import SwiftUI
import AppKit

@main
struct SudoCleanerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 600, minHeight: 500)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}

