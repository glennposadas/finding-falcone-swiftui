import SwiftUI

@main
struct FindingFalconeApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      SelectionView(viewModel: .init())
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
