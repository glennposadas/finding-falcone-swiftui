import SwiftUI

/**
 View Model of selection flow.
 TODO: make a store.
 */
final class SelectionViewModel: BaseViewModel {
  
  // MARK: - Properties
  
  /// Current state of the VM
  @Published var state: ViewModelState<[DestinationManager.Selection]> = .loading
  /// Do we have a current error?
  @Published var hasError: Bool = false
  
  /// Determines if the find falcone button is enabled or not
  @Published var findFalconeButtonIsEnabled = false
  
  /// The coordinator for this flow.
  private unowned let coordinator: SelectionCoordinator
  
  // MARK: - Functions
  // MARK: - Initialization
  
  init(coordinator: SelectionCoordinator) {
    self.coordinator = coordinator
  }
  
  // MARK: - Public
  
  /// A dedicated refresh function. 
  func refresh() async {
    await checkAndGetToken()
    await getPlanets()
    await getVehicles()
  }
  
  func checkAndGetToken() async {
#if !DEBUG
    guard API.token.isEmpty else {
      return
    }
#endif
    
    let result = await API.shared.getToken()
    
    if case .success(let tokenResponse) = result {
      print("Token: \(tokenResponse)")
      handleToken(tokenResponse.token)
    } else if case .failure(let error) = result {
      await handleError(error)
    }
  }
  
  @MainActor
  func getPlanets() async {
    let result = await API.shared.getPlanets()

    if case .success(let planets) = result {
      destinationManager.allPlanets = Set(planets.map{$0})
      destinationManager.populateInitialSelections()
      state = .success( destinationManager.selections )
      self.hasError = false
    } else if case .failure(let error ) = result {
      handleError(error)
    }
  }

  @MainActor
  func getVehicles() async {
    let result = await API.shared.getVehicles()

    if case .success(let vehicles) = result {
      var allVehicles = Set<Vehicle>()
      
      vehicles.forEach { vehicle in
        if vehicle.total == 0 {
          return
        } else if vehicle.total == 1 {
          allVehicles.insert(vehicle)
        } else {
          for index in 0..<vehicle.total - 1 {
            vehicle.name = vehicle.name + " 1"
            allVehicles.insert(vehicle)
            
            let newVehicle = vehicle.newCopy()
            // Append the index to the name.
            // For instance, index 0 means the second vehicle.
            // Therefore, #2.
            let newName = newVehicle.name.components(separatedBy: " ").first ?? ""
            newVehicle.name = newName + " \(index + 2)"
            allVehicles.insert(newVehicle)
          }
        }
      }
      
      print("Vehicles count: \(allVehicles.count)")
      
      destinationManager.allVehicles = allVehicles
      
    } else if case .failure(let error ) = result {
      handleError(error)
    }
  }
  
  // MARK: Navigations & Handlers
  
  func selectPlanet(forSelection selection: DestinationManager.Selection) {
    print("open selection for planet...")
    coordinator.openForPlanet(selection)
  }
  
  func selectVehicle(forSelection selection: DestinationManager.Selection) {
    print("open selection for vehicle...")
    coordinator.openForVehicle(selection)
  }
  
  // MARK: - Private
  
  private func handleToken(_ token: String) {
    KeychainHelper.standard.save(token.data(using: .utf8),
                                 service: .apiToken,
                                 account: .api)
  }
  
  @MainActor
  private func handleError(_ error: Error, function: String = #function) {
    self.hasError = true
    self.state = .failure(error.localizedDescription)
    print("Error SelectionViewModel \(function): \(error.localizedDescription)")
  }
 }
