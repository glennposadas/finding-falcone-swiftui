import Foundation

let destinationManager = DestinationManager.shared

/**
 The manager that handles all the selection stuff. Contains the abstracted selected `Planet` with `Vehicle`
 */
final class DestinationManager {
  class Selection: Identifiable, CustomStringConvertible {
    
    // MARK: - Enum
    
    enum SelectingFor {
      case planet
      case vehicle
    }
    
    // MARK: - Properties
    
    var id: Int
    var selection: (planet: Planet?, vehicle: Vehicle?)
    
    /// Determines the type of selection we are selecting for in the edit view.
    var selectingFor: SelectingFor = .planet
    
    var planetNamePresentable: String {
      selection.planet?.name ?? "Select a planet"
    }
    
    var vehicleNamePresentable: String {
      selection.vehicle?.name ?? "Select a vehicle"
    }
    
    // MARK: - CustomStringConvertible
    
    var description: String {
      "Selection id: \(id) | Selecting for: \(selectingFor) | Planet: \(planetNamePresentable) | Vehicle: \(vehicleNamePresentable)"
    }
    
    // MARK: - Functions
    // MARK: Initialization
    
    init(id: Int, selectionTuple: (planet: Planet?, vehicle: Vehicle?) = (nil, nil)) {
      self.id = id
      self.selection = selectionTuple
    }
  }
  
  // MARK: - Properties
  
  var selections = [Selection]()
  static let shared = DestinationManager()
  
  // MARK: - Functions
  // MARK: - Public
  
  func getTimeTaken() -> Int {
    return 0
  }
  
  func populateInitialSelections() {
    guard selections.isEmpty else { return }
    for index in 0..<AppConstants.REQUIRED_PLANETS_COUNT_FOR_SEARCH {
      selections.append(.init(id: index))
    }
  }
}
