import SwiftUI

@main
struct FindingFalconeApp: App {
  // MARK: Stored Properties
  
  @StateObject var coordinator = SelectionCoordinator()
  
  // MARK: Scenes
  
  var body: some Scene {
    WindowGroup {
      SelectionCoordinatorView(coordinator: coordinator)
    }
  }
}
