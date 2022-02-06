import SwiftUI

@main
struct FindingFalconeApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      SelectionView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
