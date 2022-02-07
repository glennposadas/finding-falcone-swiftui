import Foundation

/**
 The manager that handles all the selection stuff. Contains the abstracted selected `Planet` with `Vehicle`
 */
final class DestinationManager {
  class Selection: Identifiable {
    var id: UUID
    var selection: (planet: Planet?, vehicle: Vehicle?)
    
    var planetNamePresentable: String {
      selection.planet?.name ?? "Select a planet"
    }
    
    var vehicleNamePresentable: String {
      selection.vehicle?.name ?? "Select a vehicle"
    }
    
    init() {
      self.id = UUID()
      self.selection = (nil, nil)
    }
  }
  
  // MARK: - Properties
  
  var selections = [Selection]()
  
  // MARK: - Functions
  // MARK: - Public
  
  func getTimeTaken() -> Int {
    return 0
  }
  
  func populateInitialSelections() {
    guard selections.isEmpty else { return }
    for _ in 0..<AppConstants.REQUIRED_PLANETS_COUNT_FOR_SEARCH {
      selections.append(.init())
    }
  }
}
