import SwiftUI

@main
struct FindingFalconeApp: App {
  var body: some Scene {
    WindowGroup {
      SelectionView(viewModel: .init())
    }
  }
}
