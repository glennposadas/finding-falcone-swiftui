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
    @Published var planetNamePresentable: String
    
    /// Presentable subtitle
    @Published var vehicleNamePresentable: String
    
    // MARK: - CustomStringConvertible
    
    var description: String {
      "Selection id: \(id) | Selecting for: \(selectingFor) | Planet: \(planetNamePresentable) | Vehicle: \(vehicleNamePresentable)"
    }
    
    // MARK: - Functions
    // MARK: Initialization
    
    init(id: Int, selectionTuple: (planet: Planet?, vehicle: Vehicle?) = (nil, nil)) {
      self.id = id
      self.selection = selectionTuple
      self.planetNamePresentable = "Select a planet"
      self.vehicleNamePresentable = "Select a vehicle"
    }
  }
  
  // MARK: - Properties
  
  /// Collection of planets from the server
  var allPlanets = Array<Planet>() {
    didSet {
      // Set the dictionary state
      planetsWithSelectionState = allPlanets.reduce(into: SelectionDictionary(), {
        $0[$1.id.uuidString] = false
      })
    }
  }
  
  /// Collection of vehicles
  var allVehicles = Array<Vehicle>() {
    didSet {
      // Set the dictionary state
      vehiclesWithSelectionState = allVehicles.reduce(into: SelectionDictionary(), {
        $0[$1.id.uuidString] = false
      })
    }
  }
  
  typealias SelectionDictionary = [String : Bool]
  
  /// Key and value pair for all planets.
  /// Key as planet id, and value if selected or not
  var planetsWithSelectionState: SelectionDictionary = [:]
  /// Key and value pair for all vehicles with selection state.
  /// Key as vehicle id, and value if selected or not.
  var vehiclesWithSelectionState: SelectionDictionary = [:]
  
  /// The selection objects used by the views.
  var selections = [Selection]() {
    didSet {
      print("ssss")
    }
  }
  
  /// Singleton manager
  static let shared = DestinationManager()
  
  // MARK: - Functions
  // MARK: - Public
  
  /**
   Returns the computer time taken,
   
   - Formula:
   ``` t = distance of plant / speed of vehicle ```
   */
  func getTimeTaken() -> Int {
    var t = 0
    
    for selection in destinationManager.selections {
      guard let planet = selection.selection.planet,
            let vehicle = selection.selection.vehicle else {
              continue
            }
      
      let distance = planet.distance
      let speed = vehicle.speed
      
      print("Intial t: \(t)")
      
      if speed > 0 {
        t += distance / speed
        print("Distance: \(distance) / Speed: \(speed) = \(t)")
      }
    }
    
    return t
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
  
  /**
   Check if all selection has been filled!
   */
  func selectionsAreComplete() -> Bool {
    for selection in destinationManager.selections {
      if selection.selection.planet == nil || selection.selection.vehicle == nil {
        return false
      }
    }
    
    return true
  }
  
  /**
   Clears all selections. Game over. Start Again.
   */
  func clearAllSelections() {
    destinationManager.selections.removeAll()
  }
}

// MARK: - Is Selected

extension BaseModel {
  /// Determines if the current planet is currently selected.
  /// If yes, disable the view.
  func isSelectedOutsideSelection(selectionId: Int) -> Bool {
    for selection in destinationManager.selections {
      if selectionId != selection.id {
        if let planet = selection.selection.planet {
          if planet.id == id {
            return true
          }
        }
        
        if let vehicle = selection.selection.vehicle {
          if vehicle.id == id {
            return true
          }
        }
      }
    }
    
    return false
  }
}
