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
    
    /// Identifiable
    var id: Int
    /// The selection object
    var selection: (planet: Planet?, vehicle: Vehicle?)
    
    /// Determines the type of selection we are selecting for in the edit view.
    var selectingFor: SelectingFor = .planet
    
    /// Presentable subtitle
    var planetNamePresentable: String {
      selection.planet?.name ?? "Select a planet"
    }
    
    /// Presentable subtitle
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
    
  /// Collection of planets from the server
  var allPlanets = Set<Planet>()
  
  /// Collection of vehicles
  var allVehicles = Set<Vehicle>()
  
  /// The selection objects used by the views.
  var selections = [Selection]()
  
  /// Singleton manager
  static let shared = DestinationManager()
  
  // MARK: - Functions
  // MARK: - Public
  
  /**
   Returns the computer time taken,
   
   - Formula:
    ``` t = distance / speed ```
   */
  func getTimeTaken() -> Int {
    return 0
  }
  
  /**
   Populates all the selection.
   */
  func populateInitialSelections() {
    guard selections.isEmpty else { return }
    for index in 0..<AppConstants.REQUIRED_PLANETS_COUNT_FOR_SEARCH {
      selections.append(.init(id: index))
    }
  }
}
