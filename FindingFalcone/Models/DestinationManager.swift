import Foundation

/**
 The manager that handles all the selection stuff. Contains the abstracted selected `Planet` with `Vehicle`
 */
final class DestinationManager {
  typealias Selection = (Planet, Vehicle)
  
  var selections = [Selection]()
  
  func getTimeTaken() -> Int {
    return 0
  }
}
